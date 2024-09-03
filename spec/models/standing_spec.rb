# frozen_string_literal: true

require "rails_helper"

RSpec.describe Standing do
  it { is_expected.to be_an(ApplicationRecord) }

  it { is_expected.to belong_to(:character) }

  it { is_expected.to belong_to(:standingable).optional }

  it do
    is_expected.to belong_to(:faction)
      .conditions(standings: {standingable_type: Eve::Faction.name})
      .with_foreign_key("standingable_id")
      .class_name("Eve::Faction")
      .inverse_of(:standings)
      .optional
  end

  it do
    is_expected.to belong_to(:corporation)
      .conditions(standings: {standingable_type: Eve::Corporation.name})
      .with_foreign_key("standingable_id")
      .class_name("Eve::Corporation")
      .inverse_of(:standings)
      .optional
  end

  it do
    is_expected.to belong_to(:agent)
      .conditions(standings: {standingable_type: Eve::Agent.name})
      .with_foreign_key("standingable_id")
      .class_name("Eve::Agent")
      .inverse_of(:standings)
      .optional
  end

  describe ".factions" do
    let!(:eve_faction_1) { create(:eve_faction, name_en: "B") }

    let!(:eve_faction_2) { create(:eve_faction, name_en: "A") }

    let!(:character) { create(:character) }

    let!(:standing_1) { create(:standing, :for_faction, character: character, standingable: eve_faction_1) }

    let!(:standing_2) { create(:standing, :for_faction, character: character, standingable: eve_faction_2) }

    specify { expect(described_class.factions.includes(:faction)).to eq([standing_2, standing_1]) }
  end

  describe ".corporations" do
    let!(:eve_corporation_1) { create(:eve_corporation, name: "B") }

    let!(:eve_corporation_2) { create(:eve_corporation, name: "A") }

    let!(:character) { create(:character) }

    let!(:standing_1) { create(:standing, :for_corporation, character: character, standingable: eve_corporation_1) }

    let!(:standing_2) { create(:standing, :for_corporation, character: character, standingable: eve_corporation_2) }

    specify { expect(described_class.corporations.includes(:corporation)).to eq([standing_2, standing_1]) }
  end

  describe ".agents" do
    let!(:eve_agent_1) { create(:eve_agent, name: "B") }

    let!(:eve_agent_2) { create(:eve_agent, name: "A") }

    let!(:character) { create(:character) }

    let!(:standing_1) { create(:standing, character: character, standingable: eve_agent_1) }

    let!(:standing_2) { create(:standing, character: character, standingable: eve_agent_2) }

    specify { expect(described_class.agents.includes(:agent)).to eq([standing_2, standing_1]) }
  end

  describe "#rounded_standing" do
    subject { build(:standing, standing: 1.56789) }

    specify { expect(subject.rounded_standing).to eq("1.6") }
  end
end
