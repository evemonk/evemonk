# frozen_string_literal: true

require 'rails_helper'

describe Eve::AlliancesImporter do
  describe '#initialize' do
    let(:esi) { instance_double(EveOnline::ESI::Alliances) }

    before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(esi) }

    its(:esi) { should eq(esi) }
  end

  describe '#etag' do
    context 'when @model set' do
      let(:etag) { instance_double(Etag) }

      before { subject.instance_variable_set(:@etag, etag) }

      specify { expect(subject.etag).to eq(etag) }
    end

    context 'when @etag not set' do
      let(:url) { double }

      let(:esi) { instance_double(EveOnline::ESI::Alliances, url: url) }

      let(:etag) { instance_double(Etag) }

      before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(esi) }

      before { expect(Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      specify { expect { subject.etag }.not_to raise_error }

      specify { expect { subject.etag }.to change { subject.instance_variable_get(:@etag) }.from(nil).to(etag) }
    end
  end

  describe '#import' do
    context 'when fresh data available' do
      let(:etag) { instance_double(Etag, etag: '97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }

      let(:new_etag) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::Alliances,
                        not_modified?: false,
                        etag: new_etag)
      end

      before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(esi) }

      before { expect(subject).to receive(:etag).and_return(etag).twice }

      before { expect(esi).to receive(:etag=).with('97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }

      before { expect(subject).to receive(:import_new_alliances) }

      before { expect(subject).to receive(:remove_old_alliances) }

      before { expect(etag).to receive(:update!).with(etag: new_etag) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context 'when no fresh data available' do
      let(:etag) { instance_double(Etag, etag: '97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }

      let(:esi) do
        instance_double(EveOnline::ESI::Alliances,
                        not_modified?: true)
      end

      before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(esi) }

      before { expect(subject).to receive(:etag).and_return(etag) }

      before { expect(esi).to receive(:etag=).with('97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }

      before { expect(subject).not_to receive(:import_new_alliances) }

      before { expect(subject).not_to receive(:remove_old_alliances) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # private methods

  describe '#import_new_alliances' do
    let(:alliance_id) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::Alliances,
                      alliance_ids: [alliance_id])
    end

    before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(esi) }

    context 'when alliance not imported' do
      before do
        #
        # Eve::Alliance.where(alliance_id: alliance_id).exists? # => false
        #
        expect(Eve::Alliance).to receive(:where).with(alliance_id: alliance_id) do
          double.tap do |a|
            expect(a).to receive(:exists?).and_return(false)
          end
        end
      end

      before { expect(Eve::AllianceImporterWorker).to receive(:perform_async).with(alliance_id) }

      specify { expect { subject.send(:import_new_alliances) }.not_to raise_error }
    end

    context 'when alliance already imported' do
      before do
        #
        # Eve::Alliance.where(alliance_id: alliance_id).exists? # => true
        #
        expect(Eve::Alliance).to receive(:where).with(alliance_id: alliance_id) do
          double.tap do |a|
            expect(a).to receive(:exists?).and_return(true)
          end
        end
      end

      before { expect(Eve::AllianceImporterWorker).not_to receive(:perform_async).with(alliance_id) }

      specify { expect { subject.send(:import_new_alliances) }.not_to raise_error }
    end
  end

  # describe '#import' do
  #   context 'when fresh data available' do
  #     let(:url) { double }
  #
  #     let(:new_etag) { double }
  #
  #     let(:alliance_id) { double }
  #
  #     let(:esi) do
  #       instance_double(EveOnline::ESI::Alliances,
  #                       not_modified?: false,
  #                       url: url,
  #                       etag: new_etag,
  #                       alliance_ids: [alliance_id])
  #     end
  #
  #     before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(esi) }
  #
  #     let(:etag) { instance_double(Etag, etag: '97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }
  #
  #     before { expect(Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }
  #
  #     before { expect(esi).to receive(:etag=).with('97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }
  #
  #     before { expect(Eve::AllianceImporterWorker).to receive(:perform_async).with(alliance_id) }
  #
  #     before { expect(etag).to receive(:update!).with(etag: new_etag) }
  #
  #     specify { expect { subject.import }.not_to raise_error }
  #   end
  #
  #   context 'when no fresh data available' do
  #     let(:url) { double }
  #
  #     let(:esi) do
  #       instance_double(EveOnline::ESI::Alliances,
  #                       not_modified?: true,
  #                       url: url)
  #     end
  #
  #     before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(esi) }
  #
  #     let(:etag) { instance_double(Etag, etag: '97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }
  #
  #     before { expect(Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }
  #
  #     before { expect(esi).to receive(:etag=).with('97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }
  #
  #     before { expect(Eve::AllianceImporterWorker).not_to receive(:perform_async) }
  #
  #     specify { expect { subject.import }.not_to raise_error }
  #   end
  # end
end
