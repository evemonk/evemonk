# frozen_string_literal: true

require "rails_helper"

describe CharacterBlueprintsFilterForm do
  it { should be_an(ActiveModel::Model) }

  let(:filter) { double }

  subject { described_class.new(filter) }

  describe "#initialize" do
    its(:filter) { should eq(filter) }
  end

  describe "#select_data" do
    specify do
      expect(subject.select_data).to eq(
        [
          ["All", 0],
          ["BPO", 1],
          ["BPC", 2],
          ["Ancient Relics", 3],
          ["Stacked", 4]
        ]
      )
    end
  end

  describe "#selected" do
    specify { expect(subject.selected).to eq(filter) }
  end

  # private methods

  describe "#raw_values" do
    specify do
      expect(subject.send(:raw_values)).to eq(
        [
          {name: "All", id: 0},
          {name: "BPO", id: 1},
          {name: "BPC", id: 2},
          {name: "Ancient Relics", id: 3},
          {name: "Stacked", id: 4}
        ]
      )
    end
  end
end
