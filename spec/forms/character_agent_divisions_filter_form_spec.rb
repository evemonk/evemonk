# frozen_string_literal: true

require "rails_helper"

describe CharacterAgentDivisionsFilterForm do
  it { should be_an(ActiveModel::Model) }

  let(:division_id) { double }

  subject { described_class.new(division_id) }

  describe "#initialize" do
    its(:division_id) { should eq(division_id) }
  end

  describe "#select_data" do
    let!(:eve_division) { create(:eve_division, name: "Security") }

    specify do
      expect(subject.select_data).to eq(
        [
          ["Division: All", -1],
          ["Division: Security", eve_division.id]
        ]
      )
    end
  end

  describe "#selected" do
    specify { expect(subject.selected).to eq(division_id) }
  end
end
