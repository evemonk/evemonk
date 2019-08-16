# frozen_string_literal: true

require "rails_helper"

describe ApplicationDecorator do
  subject { described_class.new(double) }

  it { should be_a(Draper::Decorator) }

  describe "#imageproxy_url" do
    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.imageproxy_url).to eq("https://imageproxy.evemonk.com/") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.imageproxy_url).to eq(nil) }
    end
  end

  describe ".collection_decorator_class" do
    specify { expect(described_class.collection_decorator_class).to eq(PaginatingDecorator) }
  end
end
