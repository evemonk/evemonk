# frozen_string_literal: true

require "rails_helper"

describe Eve::FactionDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#size_factor" do
    let(:eve_faction) do
      build(:eve_faction,
        size_factor: 2.0)
    end

    subject { eve_faction.decorate }

    specify { expect(subject.size_factor).to eq("2.0") }
  end

  describe "#icon_tiny" do
    let(:eve_faction) do
      build(:eve_faction,
        faction_id: 500_001)
    end

    subject { eve_faction.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/alliances/500001/logo?size=32&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/alliances/500001/logo?size=32&tenant=tranquility") }
    end
  end

  describe "#icon_small" do
    let(:eve_faction) do
      build(:eve_faction,
        faction_id: 500_001)
    end

    subject { eve_faction.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/alliances/500001/logo?size=64&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_small).to eq("https://images.evetech.net/alliances/500001/logo?size=64&tenant=tranquility") }
    end
  end

  describe "#icon_medium" do
    let(:eve_faction) do
      build(:eve_faction,
        faction_id: 500_001)
    end

    subject { eve_faction.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_medium).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/alliances/500001/logo?size=128&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_medium).to eq("https://images.evetech.net/alliances/500001/logo?size=128&tenant=tranquility") }
    end
  end
end
