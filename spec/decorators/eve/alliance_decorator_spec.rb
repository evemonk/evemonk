# frozen_string_literal: true

require "rails_helper"

describe Eve::AllianceDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#date_founded" do
    let(:eve_alliance) do
      build(:eve_alliance,
            date_founded: "Sun, 03 May 2015 19:45:17 UTC +00:00")
    end

    subject { eve_alliance.decorate }

    specify { expect(subject.date_founded).to eq("2015-05-03T19:45:17Z") }
  end

  describe "#icon_tiny" do
    let(:eve_alliance) do
      build(:eve_alliance,
            alliance_id: 123)
    end

    subject { eve_alliance.decorate }

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
    let(:eve_alliance) do
      build(:eve_alliance,
            alliance_id: 123)
    end

    subject { eve_alliance.decorate }

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
    let(:eve_alliance) do
      build(:eve_alliance,
            alliance_id: 123)
    end

    subject { eve_alliance.decorate }

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
