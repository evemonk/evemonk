# frozen_string_literal: true

require "rails_helper"

describe CharacterStandingsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#update!" do
    context "when scope present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "esi-characters.read_standings.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(4).times }

      let(:from_id) { double }

      let(:standing) { double }

      let(:model) do
        instance_double(EveOnline::ESI::Models::Standing,
          from_id: from_id,
          from_type: from_type,
          standing: standing)
      end

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterStandings,
          standings: [model],
          scope: "esi-characters.read_standings.v1")
      end

      before { expect(EveOnline::ESI::CharacterStandings).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      let(:character_standing) { instance_double(Standing) }

      before do
        #
        # character.standings.find_or_initialize_by(from_id: standing.from_id,
        #                                           from_type: standing.from_type) # => character_standing
        #
        expect(character).to receive(:standings) do
          double.tap do |a|
            expect(a).to receive(:find_or_initialize_by).with(from_id: from_id, from_type: from_type)
              .and_return(character_standing)
          end
        end
      end

      context "when from_type is faction" do
        let(:from_type) { "faction" }

        let(:standingable) { instance_double(Eve::Faction) }

        before { expect(Eve::Faction).to receive(:find_by).with(faction_id: from_id).and_return(standingable) }

        before { expect(character_standing).to receive(:assign_attributes).with(standingable: standingable, standing: standing) }

        before { expect(character_standing).to receive(:save!) }

        specify { expect { subject.update! }.not_to raise_error }
      end

      context "when from_type is npc_corp" do
        let(:from_type) { "npc_corp" }

        let(:standingable) { instance_double(Eve::Corporation) }

        before { expect(Eve::Corporation).to receive(:find_by).with(corporation_id: from_id).and_return(standingable) }

        before { expect(character_standing).to receive(:assign_attributes).with(standingable: standingable, standing: standing) }

        before { expect(character_standing).to receive(:save!) }

        specify { expect { subject.update! }.not_to raise_error }
      end

      context "when from_type is agent" do
        let(:from_type) { "agent" }

        let(:standingable) { instance_double(Eve::Agent) }

        before { expect(Eve::Agent).to receive(:find_by).with(agent_id: from_id).and_return(standingable) }

        before { expect(character_standing).to receive(:assign_attributes).with(standingable: standingable, standing: standing) }

        before { expect(character_standing).to receive(:save!) }

        specify { expect { subject.update! }.not_to raise_error }
      end

      context "when from_type is unknown" do
        let(:from_type) { "unknown" }

        specify { expect { subject.update! }.to raise_error("Unknown standing from type") }
      end
    end

    context "when scope not present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(3).times }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterStandings,
          scope: "esi-characters.read_standings.v1")
      end

      before { expect(EveOnline::ESI::CharacterStandings).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      before { expect(character).not_to receive(:standings) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end
end
