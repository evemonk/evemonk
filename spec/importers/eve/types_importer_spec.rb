# frozen_string_literal: true

require 'rails_helper'

describe Eve::TypesImporter do
  describe '#initialize' do
    let(:page) { 1 }

    subject { described_class.new(page) }

    its(:page) { should eq(page) }
  end

  describe '#import' do
    let(:page) { 1 }

    subject(:importer) { described_class.new(page) }

    specify { expect { importer.import }.not_to raise_error }
  end
end
