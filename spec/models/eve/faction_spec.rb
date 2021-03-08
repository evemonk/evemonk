# frozen_string_literal: true

require "rails_helper"

describe Eve::Faction do
  let(:attributes) do
    attributes_for(:eve_faction).merge(id: 1,
      created_at: Time.zone.now,
      updated_at: Time.zone.now)
  end

  subject { described_class.new(**attributes) }

  it { should be_a(Upgrow::Model) }

  describe "#icon_tiny" do
    subject { described_class.new(**attributes.merge(faction_id: 500_001)) }

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
    subject { described_class.new(**attributes.merge(faction_id: 500_001)) }

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
    subject { described_class.new(**attributes.merge(faction_id: 500_001)) }

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
