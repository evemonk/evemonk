# frozen_string_literal: true

require "rails_helper"

describe Eve::Faction do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("faction_id") }

  it { should be_a(Imageable) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_factions") }

  it { should belong_to(:corporation).optional(true) }

  it { should belong_to(:militia_corporation).class_name("Eve::Corporation").with_primary_key("corporation_id").with_foreign_key("militia_corporation_id").optional(true) }

  it { should belong_to(:solar_system).class_name("Eve::System").with_primary_key("system_id").with_foreign_key("solar_system_id").optional(true) }

  it { should have_many(:alliances) }

  it { should have_many(:standings) }

  describe "#icon_tiny" do
    before { expect(subject).to receive(:corporations_logo_url).with(32) }

    specify { expect { subject.icon_tiny }.not_to raise_error }
  end

  describe "#icon_small" do
    before { expect(subject).to receive(:corporations_logo_url).with(64) }

    specify { expect { subject.icon_small }.not_to raise_error }
  end

  describe "#icon_medium" do
    before { expect(subject).to receive(:corporations_logo_url).with(128) }

    specify { expect { subject.icon_medium }.not_to raise_error }
  end

  # private methods

  describe "#corporations_logo_url" do
    subject { build(:eve_faction, faction_id: 500_001) }

    before do
      #
      # imageable_url("corporations", faction_id, "logo", size)
      #
      expect(subject).to receive(:imageable_url).with("corporations", 500_001, "logo", 128)
    end

    specify { expect { subject.send(:corporations_logo_url, 128) }.not_to raise_error }
  end
end
