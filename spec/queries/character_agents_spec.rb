# frozen_string_literal: true

require "rails_helper"

describe CharacterAgents do
  let(:character) { double }

  let(:division_id) { double }

  subject { described_class.new(character, division_id) }

  describe "#initialize" do
    its(:character) { should eq(character) }

    its(:division_id) { should eq(division_id) }
  end

  describe "#query" do
    context "when @character_agents is already set" do
      let(:character_agents) { double }

      before { subject.instance_variable_set(:@character_agents, character_agents) }

      specify { expect(subject.query).to eq(character_agents) }
    end

    context "when division_id is blank or -1" do
      let!(:character) { create(:character) }

      let!(:eve_agent_1) { create(:eve_agent, name: "ABC") }

      let!(:eve_agent_2) { create(:eve_agent, name: "DEF") }

      let!(:standing_1) { create(:standing, :for_agent, character: character, standingable: eve_agent_1) }

      let!(:standing_2) { create(:standing, :for_agent, character: character, standingable: eve_agent_2) }

      context "when blank" do
        let(:division_id) { "" }

        specify { expect(subject.query).to eq([standing_1, standing_2]) }
      end

      context "when -1" do
        let(:division_id) { "-1" }

        specify { expect(subject.query).to eq([standing_1, standing_2]) }
      end
    end

    context "when division_id is present" do
      let!(:character) { create(:character) }

      let!(:eve_division_1) { create(:eve_division) }

      let!(:eve_division_2) { create(:eve_division) }

      let!(:eve_agent_1) do
        create(:eve_agent,
          name: "ABC",
          division: eve_division_1)
      end

      let!(:eve_agent_2) do
        create(:eve_agent,
          name: "DEF",
          division: eve_division_2)
      end

      let!(:standing_1) do
        create(:standing,
          :for_agent,
          character: character,
          standingable: eve_agent_1)
      end

      let!(:standing_2) do
        create(:standing,
          :for_agent,
          character: character,
          standingable: eve_agent_2)
      end

      let(:division_id) { eve_division_1.id }

      specify { expect(subject.query).to eq([standing_1]) }
    end
  end
end
