# frozen_string_literal: true

require "rails_helper"

describe Eve::AllianceCorporation do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_alliance_corporations") }

  it { should belong_to(:alliance).with_primary_key(:alliance_id).counter_cache(:corporations_count).optional(true) }

  it { should belong_to(:corporation).with_primary_key(:corporation_id).optional(true) }

  it { should callback(:eve_alliance_reset_characters_count).after(:commit).on([:create, :update, :destroy]) }

  describe "#eve_alliance_reset_characters_count" do
    context "when alliance exists" do
      let!(:eve_alliance) { create(:eve_alliance) }

      let!(:eve_corporation) { create(:eve_corporation, alliance: eve_alliance) }

      let!(:eve_alliance_corporation) { create(:eve_alliance_corporation, alliance: eve_alliance, corporation: eve_corporation) }

      subject { eve_alliance_corporation }

      before { expect(eve_alliance).to receive(:reset_characters_count) }

      specify { expect { subject.eve_alliance_reset_characters_count }.not_to raise_error }
    end

    context "when alliance not exists" do
      let!(:eve_alliance_corporation) { create(:eve_alliance_corporation) }

      subject { eve_alliance_corporation }

      specify { expect { subject.eve_alliance_reset_characters_count }.not_to raise_error }
    end
  end
end
