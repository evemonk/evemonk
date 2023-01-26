# frozen_string_literal: true

require "rails_helper"

describe CorporationMembersImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#import!" do
    let(:character_id) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::CorporationMembers,
        character_ids: [character_id])
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    before { expect(Eve::UpdateCharacterJob).to receive(:perform_later).with(character_id) }

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CorporationMembers) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CorporationMembers) }

      let(:corporation_id) { double }

      let(:character) { instance_double(Character, corporation_id: corporation_id) }

      before { expect(subject).to receive(:character).and_return(character) }

      before { expect(EveOnline::ESI::CorporationMembers).to receive(:new).with(corporation_id: corporation_id).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
