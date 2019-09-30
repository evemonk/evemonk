# frozen_string_literal: true

require "rails_helper"

describe Eve::TypeDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#icon_tiny" do
    let(:eve_type) do
      build(:eve_type,
            type_id: 123)
    end

    subject { eve_type.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Type/123_32.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_tiny).to eq("https://imageserver.eveonline.com/Type/123_32.png") }
    end
  end

  describe "#icon_small" do
    let(:eve_type) do
      build(:eve_type,
            type_id: 123)
    end

    subject { eve_type.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Type/123_64.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_small).to eq("https://imageserver.eveonline.com/Type/123_64.png") }
    end
  end
end
