# frozen_string_literal: true

require "rails_helper"

describe ImageProxy do
  let(:klass) { Class.new }

  before do
    klass.class_eval do
      include ImageProxy
    end
  end

  describe "#imageproxy_url" do
    subject { klass.new }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.imageproxy_url).to eq("https://imageproxy.evemonk.com/") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.imageproxy_url).to eq(nil) }
    end
  end
end
