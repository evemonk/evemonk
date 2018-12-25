# frozen_string_literal: true

require 'rails_helper'

describe Eve::AllianceImporter do
  describe '#import' do
    context 'when fresh data available' do
      context 'when alliance exists' do
        let(:alliance_id) { double }

        let(:etag) { double }

        subject { described_class.new(alliance_id) }

        before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(alliance_id: alliance_id).and_return(eve_alliance) }

        let(:json) { double }

        let(:eveonline_esi_alliance) do
          instance_double(EveOnline::ESI::Alliance,
                          not_modified?: false,
                          as_json: json)
        end

        before { expect(EveOnline::ESI::Alliance).to receive(:new).with(alliance_id: alliance_id, etag: etag).and_return(eveonline_esi_alliance) }

        before { expect(eve_alliance).to receive(:assign_attributes).with(json) }

        context 'when alliance is changed' do
          let(:eve_alliance) do
            instance_double(Eve::Alliance,
                            etag: etag,
                            changed?: true)
          end

          before { expect(eve_alliance).to receive(:save!) }

          specify { expect { subject.import }.not_to raise_error }
        end

        context 'when alliance not changed' do
          let(:eve_alliance) do
            instance_double(Eve::Alliance,
                            etag: etag,
                            changed?: false)
          end

          before { expect(eve_alliance).not_to receive(:save!) }

          specify { expect { subject.import }.not_to raise_error }
        end
      end

      context 'when alliance not found' do
      end
    end

    context 'when no fresh data available' do
      let(:alliance_id) { double }

      let(:etag) { double }

      subject { described_class.new(alliance_id) }

      let(:eve_alliance) { instance_double(Eve::Alliance, etag: etag) }

      before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(alliance_id: alliance_id).and_return(eve_alliance) }

      let(:eveonline_esi_alliance) do
        instance_double(EveOnline::ESI::Alliance,
                        not_modified?: true)
      end

      before { expect(EveOnline::ESI::Alliance).to receive(:new).with(alliance_id: alliance_id, etag: etag).and_return(eveonline_esi_alliance) }

      specify { expect { subject.import }.not_to raise_error }
    end

    # context 'when alliance not found' do
    #   let(:alliance_id) { double }

    #   subject { described_class.new(alliance_id) }

    #   before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(alliance_id: alliance_id).and_return(eve_alliance) }

    #   before { expect(EveOnline::ESI::Alliance).to receive(:new).and_raise(EveOnline::Exceptions::ResourceNotFound) }

    #   context 'when alliance persisted' do
    #     let(:eve_alliance) { instance_double(Eve::Alliance, persisted?: true) }

    #     before { expect(eve_alliance).to receive(:destroy) }

    #     specify { expect { subject.import }.not_to raise_error }
    #   end

    #   context 'when alliance not persisted' do
    #     let(:eve_alliance) { instance_double(Eve::Alliance, persisted?: false) }

    #     before { expect(eve_alliance).not_to receive(:destroy) }

    #     specify { expect { subject.import }.not_to raise_error }
    #   end
    # end
  end
end
