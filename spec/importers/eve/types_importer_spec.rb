# frozen_string_literal: true

require 'rails_helper'

describe Eve::TypesImporter do
  describe '#initialize' do
    context 'with page' do
      let(:page) { double }

      let(:options) { { page: page } }

      subject { described_class.new(options) }

      its(:page) { should eq(page) }
    end

    context 'without page' do
      its(:page) { should eq(1) }
    end
  end

  describe '#import' do
    let(:options) { { page: 1 } }

    subject(:importer) { described_class.new(options) }

    specify { expect { importer.import }.not_to raise_error }
  end
end
