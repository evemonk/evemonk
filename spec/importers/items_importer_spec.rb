require 'rails_helper'

describe ItemsImporter do
  describe '#initialize' do
    let(:file) { double }

    let(:items) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::Items.new(file) => items
      #
      expect(EveOnline::SDE::Items).to receive(:new).with(file).and_return(items)
    end

    specify { expect(subject.items).to eq(items) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:item) { double }

    let(:json) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.items.items => [item]
      #
      expect(subject).to receive(:items) do
        double.tap do |a|
          expect(a).to receive(:items).and_return([item])
        end
      end
    end

    before { expect(item).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Item.create!(json)
      #
      expect(Eve::Item).to receive(:create!).with(json)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
