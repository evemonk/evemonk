# frozen_string_literal: true
require 'rails_helper'

describe ItemsImporter do
  describe '#initialize' do
    let(:file) { double }

    let(:inv_items) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::InvItems.new(file) => inv_items
      #
      expect(EveOnline::SDE::InvItems).to receive(:new).with(file).and_return(inv_items)
    end

    specify { expect(subject.inv_items).to eq(inv_items) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:inv_item) { double }

    let(:json) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.inv_items.inv_items => [inv_item]
      #
      expect(subject).to receive(:inv_items) do
        double.tap do |a|
          expect(a).to receive(:inv_items).and_return([inv_item])
        end
      end
    end

    before { expect(inv_item).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Item.create!(json)
      #
      expect(Eve::Item).to receive(:create!).with(json)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
