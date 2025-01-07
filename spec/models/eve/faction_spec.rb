# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Faction, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to be_a(Imageable) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_factions") }

  it { expect(subject).to belong_to(:corporation).optional(true) }

  it { expect(subject).to belong_to(:militia_corporation).class_name("Eve::Corporation").optional(true) }

  it { expect(subject).to belong_to(:solar_system).class_name("Eve::System").optional(true) }

  it { expect(subject).to have_many(:alliances) }

  it { expect(subject).to have_many(:standings) }

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
    subject { build(:eve_faction, id: 500_001) }

    before do
      #
      # imageable_url("corporations", id, "logo", size)
      #
      expect(subject).to receive(:imageable_url).with("corporations", 500_001, "logo", 128)
    end

    specify { expect { subject.send(:corporations_logo_url, 128) }.not_to raise_error }
  end
end
