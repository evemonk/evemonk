# frozen_string_literal: true

require 'rails_helper'

describe Eve::TypesImporter do
  describe '#initialize' do
    context 'with page' do
      let(:page) { double }

      let(:esi) { instance_double(EveOnline::ESI::UniverseTypes) }

      before { expect(EveOnline::ESI::UniverseTypes).to receive(:new).with(page: page).and_return(esi) }

      subject { described_class.new(page) }

      its(:page) { should eq(page) }

      its(:esi) { should eq(esi) }
    end

    context 'without page' do
      let(:esi) { instance_double(EveOnline::ESI::UniverseTypes) }

      before { expect(EveOnline::ESI::UniverseTypes).to receive(:new).with(page: 1).and_return(esi) }

      its(:page) { should eq(1) }

      its(:esi) { should eq(esi) }
    end
  end

  describe '#import' do
    context 'when fresh data available' do
      let(:page) { double }

      subject { described_class.new(page) }

      let(:new_etag) { double }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseTypes,
                        not_modified?: false,
                        etag: new_etag,
                        url: url)
      end

      before { expect(EveOnline::ESI::UniverseTypes).to receive(:new).with(page: page).and_return(esi) }

      let(:etag) { instance_double(Etag, etag: '97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }

      before { expect(Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with('97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }

      before { expect(subject).to receive(:import_types) }

      before { expect(subject).to receive(:import_other_pages) }

      before { expect(etag).to receive(:update!).with(etag: new_etag) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context 'when no fresh data available' do
      let(:page) { double }

      subject { described_class.new(page) }

      let(:etag) { instance_double(Etag, etag: '97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseTypes,
                        not_modified?: true,
                        url: url)
      end

      before { expect(EveOnline::ESI::UniverseTypes).to receive(:new).with(page: page).and_return(esi) }

      before { expect(Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with('97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }

      before { expect(subject).not_to receive(:import_types) }

      before { expect(subject).not_to receive(:import_other_pages) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # describe '#import' do
  #   let(:page) { 1 }
  #
  #   subject(:importer) { described_class.new(page) }
  #
  #   specify { expect { importer.import }.not_to raise_error }
  # end
end
