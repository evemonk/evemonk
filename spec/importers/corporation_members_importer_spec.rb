# frozen_string_literal: true

require "rails_helper"

describe CorporationMembersImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#update!" do
    context "when scope present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:corporation_id) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          corporation_id: corporation_id,
          access_token: access_token,
          scopes: "esi-corporations.read_corporation_membership.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(3).times }

      let(:character_id) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::CorporationMembers,
          character_ids: [character_id],
          scope: "esi-corporations.read_corporation_membership.v1")
      end

      before { expect(EveOnline::ESI::CorporationMembers).to receive(:new).with(corporation_id: corporation_id, token: access_token).and_return(esi) }

      before { expect(Eve::UpdateCharacterJob).to receive(:perform_later).with(character_id) }

      specify { expect { subject.update! }.not_to raise_error }
    end

    context "when scope not present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:corporation_id) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          corporation_id: corporation_id,
          access_token: access_token,
          scopes: "")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(3).times }

      let(:esi) do
        instance_double(EveOnline::ESI::CorporationMembers,
          scope: "esi-corporations.read_corporation_membership.v1")
      end

      before { expect(EveOnline::ESI::CorporationMembers).to receive(:new).with(corporation_id: corporation_id, token: access_token).and_return(esi) }

      before { expect(Eve::UpdateCharacterJob).not_to receive(:perform_later) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end
end
