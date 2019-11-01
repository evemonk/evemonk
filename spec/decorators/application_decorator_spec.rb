# frozen_string_literal: true

require "rails_helper"

describe ApplicationDecorator do
  subject { described_class.new(double) }

  it { should be_a(Draper::Decorator) }

  describe "#imageproxy_url" do
    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.imageproxy_url).to eq("https://imageproxy.evemonk.com/") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.imageproxy_url).to eq(nil) }
    end
  end

  describe ".collection_decorator_class" do
    specify { expect(described_class.collection_decorator_class).to eq(PaginatingDecorator) }
  end
end
