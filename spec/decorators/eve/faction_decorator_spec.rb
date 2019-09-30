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
        faction_id: 123)
    end

    subject { eve_faction.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Alliance/123_32.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_tiny).to eq("https://imageserver.eveonline.com/Alliance/123_32.png") }
    end
  end

  describe "#icon_small" do
    let(:eve_faction) do
      build(:eve_faction,
        faction_id: 123)
    end

    subject { eve_faction.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Alliance/123_64.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_small).to eq("https://imageserver.eveonline.com/Alliance/123_64.png") }
    end
  end

  describe "#icon_medium" do
    let(:eve_faction) do
      build(:eve_faction,
        faction_id: 123)
    end

    subject { eve_faction.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_medium).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Alliance/123_128.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_medium).to eq("https://imageserver.eveonline.com/Alliance/123_128.png") }
    end
  end
end
