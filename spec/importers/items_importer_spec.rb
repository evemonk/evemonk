require 'rails_helper'

describe ItemsImporter do
  describe '#initialize' do
    let(:file) { double }

    let(:items) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::Base.new(file) => items
      #
      expect(EveOnline::SDE::Base).to receive(:new).with(file).and_return(items)
    end

    specify { expect(subject.items).to eq(items) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:item) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.items.data => [item]
      #
      expect(subject).to receive(:items) do
        double.tap do |a|
          expect(a).to receive(:data).and_return([item])
        end
      end
    end

    before do
      #
      # Eve::Item.create!(item)
      #
      expect(Eve::Item).to receive(:create!).with(item)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
