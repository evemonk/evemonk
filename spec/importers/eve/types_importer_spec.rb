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

  # private methods

  describe '#import_types' do
    # let(:page) { double }
    #
    # subject { described_class.new(page) }

  end

  # TODO: add specs
  # def import_types
  #   esi.universe_type_ids.each do |type_id|
  #     if !Eve::Type.where(type_id: type_id).exists?
  #       Eve::TypeImporterWorker.perform_async(type_id)
  #     end
  #   end
  # end

  describe '#import_other_pages' do
    context 'when page is more than 1' do
      let(:page) { 2 }

      subject { described_class.new(page) }

      let(:esi) { instance_double(EveOnline::ESI::UniverseTypes) }

      before { expect(EveOnline::ESI::UniverseTypes).to receive(:new).with(page: page).and_return(esi) }

      before { expect(Eve::TypesImporterWorker).not_to receive(:perform_async) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end

    context 'when total pages is 1' do
      let(:page) { 1 }

      subject { described_class.new(page) }

      let(:esi) { instance_double(EveOnline::ESI::UniverseTypes, total_pages: 1) }

      before { expect(EveOnline::ESI::UniverseTypes).to receive(:new).with(page: page).and_return(esi) }

      before { expect(Eve::TypesImporterWorker).not_to receive(:perform_async) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end

    context 'when page is 1 and total pages more than 1' do
      let(:page) { 1 }

      subject { described_class.new(page) }

      let(:esi) { instance_double(EveOnline::ESI::UniverseTypes, total_pages: 2) }

      before { expect(EveOnline::ESI::UniverseTypes).to receive(:new).with(page: page).and_return(esi) }

      before { expect(Eve::TypesImporterWorker).to receive(:perform_async).with(2) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end
  end
end
