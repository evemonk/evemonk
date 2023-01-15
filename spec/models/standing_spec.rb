# frozen_string_literal: true

require "rails_helper"

describe Standing do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { should belong_to(:character) }

  it { should belong_to(:standingable).optional(true) }

  describe ".factions" do
    let!(:eve_faction_1) { create(:eve_faction, name_en: "A") }

    let!(:eve_faction_2) { create(:eve_faction, name_en: "B") }

    let!(:character) { create(:character) }

    let!(:standing_1) { create(:standing, :for_faction, character: character, standingable: eve_faction_1) }

    let!(:standing_2) { create(:standing, :for_faction, character: character, standingable: eve_faction_2) }

    specify { expect(described_class.factions).to eq([standing_1, standing_2]) }
  end

  describe ".corporations" do
    let!(:eve_corporation_1) { create(:eve_corporation, name: "A") }

    let!(:eve_corporation_2) { create(:eve_corporation, name: "B") }

    let!(:character) { create(:character) }

    let!(:standing_1) { create(:standing, :for_corporation, character: character, standingable: eve_corporation_1) }

    let!(:standing_2) { create(:standing, :for_corporation, character: character, standingable: eve_corporation_2) }

    specify { expect(described_class.corporations).to eq([standing_1, standing_2]) }
  end

  # describe ".agents" do
  #   let!(:eve_faction_1) { create(:eve_faction, name_en: "Faction A") }
  #
  #   let!(:eve_faction_2) { create(:eve_faction, name_en: "Faction B") }
  #
  #   let!(:eve_corporation_1) { create(:eve_corporation, name: "Corporation A") }
  #
  #   let!(:eve_corporation_2) { create(:eve_corporation, name: "Corporation B") }
  #
  #   let!(:eve_agent_1) { create(:eve_agent, name: "Agent A") }
  #
  #   let!(:eve_agent_2) { create(:eve_agent, name: "Agent B") }
  #
  #   let!(:character) { create(:character) }
  #
  #   let!(:standing_1) { create(:standing, character: character, standingable: eve_faction_1) }
  #
  #   let!(:standing_2) { create(:standing, character: character, standingable: eve_faction_2) }
  #
  #   let!(:standing_3) { create(:standing, character: character, standingable: eve_corporation_1) }
  #
  #   let!(:standing_4) { create(:standing, character: character, standingable: eve_corporation_2) }
  #
  #   let!(:standing_5) { create(:standing, character: character, standingable: eve_agent_1) }
  #
  #   let!(:standing_6) { create(:standing, character: character, standingable: eve_agent_2) }
  #
  #   specify { expect(described_class.agents).to eq([standing_5, standing_6]) }
  # end

  describe "#rounded_standing" do
    subject { build(:standing, standing: 1.56789) }

    specify { expect(subject.rounded_standing).to eq("1.6") }
  end
end
