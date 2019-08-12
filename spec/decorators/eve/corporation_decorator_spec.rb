# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#date_founded" do
    context "when date_founded is empty" do
      let(:eve_corporation) do
        build(:eve_corporation,
              date_founded: nil)
      end

      subject { eve_corporation.decorate }

      specify { expect(subject.date_founded).to eq(nil) }
    end

    context "when date_founded is present" do
      let(:eve_corporation) do
        build(:eve_corporation,
              date_founded: "Sun, 03 May 2015 19:45:17 UTC +00:00")
      end

      subject { eve_corporation.decorate }

      specify { expect(subject.date_founded).to eq("2015-05-03T19:45:17Z") }
    end
  end

  describe "#description" do
    let(:eve_corporation) do
      build(:eve_corporation,
            description: "<b>Test</b>")
    end

    subject { eve_corporation.decorate }

    specify { expect(subject.description).to eq("Test") }
  end

  describe "#icon_tiny" do
    let(:eve_corporation) do
      build(:eve_corporation,
            corporation_id: 123)
    end

    subject { eve_corporation.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/123_32.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_tiny).to eq("https://imageserver.eveonline.com/Corporation/123_32.png") }
    end
  end

  describe "#icon_small" do
    let(:eve_corporation) do
      build(:eve_corporation,
            corporation_id: 123)
    end

    subject { eve_corporation.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/123_64.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_small).to eq("https://imageserver.eveonline.com/Corporation/123_64.png") }
    end
  end

  describe "#icon_medium" do
    let(:eve_corporation) do
      build(:eve_corporation,
            corporation_id: 123)
    end

    subject { eve_corporation.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_medium).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/123_128.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_medium).to eq("https://imageserver.eveonline.com/Corporation/123_128.png") }
    end
  end

  describe "#icon_large" do
    let(:eve_corporation) do
      build(:eve_corporation,
            corporation_id: 123)
    end

    subject { eve_corporation.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_large).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/123_256.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_large).to eq("https://imageserver.eveonline.com/Corporation/123_256.png") }
    end
  end

  describe "#tax_rate" do
    let(:eve_corporation) do
      build(:eve_corporation,
            tax_rate: 0.99)
    end

    subject { eve_corporation.decorate }

    specify { expect(subject.tax_rate).to eq("0.99") }
  end
end
