# frozen_string_literal: true

require "rails_helper"

describe Standing do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { should belong_to(:character) }

  it { should belong_to(:standingable).optional(true) }

  it do
    should belong_to(:faction)
      .conditions(standings: { standingable_type: Eve::Faction.name })
      .with_foreign_key("standingable_id")
      .class_name("Eve::Faction")
      .inverse_of(:standings)
      .optional(true)
  end

  it do
    should belong_to(:corporation)
      .conditions(standings: { standingable_type: Eve::Corporation.name })
      .with_foreign_key("standingable_id")
      .class_name("Eve::Corporation")
      .inverse_of(:standings)
      .optional(true)
  end

  it do
    should belong_to(:agent)
      .conditions(standings: { standingable_type: Eve::Agent.name })
      .with_foreign_key("standingable_id")
      .class_name("Eve::Agent")
      .inverse_of(:standings)
      .optional(true)
  end

  describe ".factions" do
    let!(:eve_faction_1) { create(:eve_faction, name_en: "B") }

    let!(:eve_faction_2) { create(:eve_faction, name_en: "A") }

    let!(:character) { create(:character) }

    let!(:standing_1) { create(:standing, :for_faction, character: character, standingable: eve_faction_1) }

    let!(:standing_2) { create(:standing, :for_faction, character: character, standingable: eve_faction_2) }

    specify { expect(described_class.factions.includes(:faction)).to eq([standing_2, standing_1]) }
  end

  # scope :corporations, -> do
  #   where(standings: { standingable_type: Eve::Corporation.name })
  #     .order("eve_corporations.name ASC")
  # end
  #
  # scope :agents, -> do
  #   where(standings: { standingable_type: Eve::Agent.name })
  #     .order("eve_agents.name ASC")
  # end

  # describe ".corporations" do
  #   let!(:eve_corporation_1) { create(:eve_corporation, name: "A") }
  #
  #   let!(:eve_corporation_2) { create(:eve_corporation, name: "B") }
  #
  #   let!(:character) { create(:character) }
  #
  #   let!(:standing_1) { create(:standing, :for_corporation, character: character, standingable: eve_corporation_1) }
  #
  #   let!(:standing_2) { create(:standing, :for_corporation, character: character, standingable: eve_corporation_2) }
  #
  #   specify { expect(described_class.corporations).to eq([standing_1, standing_2]) }
  # end
  #
  # describe ".agents" do
  #   let!(:eve_agent_1) { create(:eve_agent, name: "A") }
  #
  #   let!(:eve_agent_2) { create(:eve_agent, name: "B") }
  #
  #   let!(:character) { create(:character) }
  #
  #   let!(:standing_1) { create(:standing, character: character, standingable: eve_agent_1) }
  #
  #   let!(:standing_2) { create(:standing, character: character, standingable: eve_agent_2) }
  #
  #   specify { expect(described_class.agents).to eq([standing_2, standing_1]) }
  # end

  describe "#rounded_standing" do
    subject { build(:standing, standing: 1.56789) }

    specify { expect(subject.rounded_standing).to eq("1.6") }
  end
end
