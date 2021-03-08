# frozen_string_literal: true

require "rails_helper"

describe Eve::Faction do
  it { should be_a(ImageProxy) }

  it { should belong_to(:corporation).with_primary_key("corporation_id").optional(true) }

  it { should belong_to(:militia_corporation).class_name("Eve::Corporation").with_primary_key("corporation_id").with_foreign_key("militia_corporation_id").optional(true) }

  it { should belong_to(:solar_system).class_name("Eve::System").with_primary_key("system_id").with_foreign_key("solar_system_id").optional(true) }

  it { should have_many(:alliances).with_primary_key("faction_id") }

  it { should have_many(:standings) }

  describe "#icon_tiny" do
    subject do
      build(:eve_faction,
        faction_id: 500_001)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/corporations/500001/logo?size=32") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/corporations/500001/logo?size=32") }
    end
  end

  describe "#icon_small" do
    subject do
      build(:eve_faction,
        faction_id: 500_001)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/corporations/500001/logo?size=64") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_small).to eq("https://images.evetech.net/corporations/500001/logo?size=64") }
    end
  end

  describe "#icon_medium" do
    subject do
      build(:eve_faction,
        faction_id: 500_001)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_medium).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/corporations/500001/logo?size=128") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_medium).to eq("https://images.evetech.net/corporations/500001/logo?size=128") }
    end
  end
end
