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

  # describe '#import' do
  #   let(:page) { 1 }
  #
  #   subject(:importer) { described_class.new(page) }
  #
  #   specify { expect { importer.import }.not_to raise_error }
  # end
end
