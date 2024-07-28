# frozen_string_literal: true

require "rails_helper"

RSpec.describe Imageable do
  let(:klass) { Class.new }

  before do
    klass.class_eval do
      include Imageable
    end
  end

  describe "#imageproxy_url" do
    subject { klass.new }

    context "when use_image_proxy is true" do
      before { Rails.application.config.evemonk.use_image_proxy = true }

      before { Rails.application.config.evemonk.image_proxy_url = "https://imageproxy.evemonk.com/" }

      after { Rails.application.config.evemonk.use_image_proxy = false }

      after { Rails.application.config.evemonk.image_proxy_url = "" }

      specify { expect(subject.imageproxy_url).to eq("https://imageproxy.evemonk.com/") }
    end

    context "when use_image_proxy is false" do
      before { Rails.application.config.evemonk.use_image_proxy = false }

      specify { expect(subject.imageproxy_url).to eq(nil) }
    end
  end

  describe "#imageable_url" do
    subject { klass.new }

    context "when use_image_proxy is true" do
      before { Rails.application.config.evemonk.use_image_proxy = true }

      before { Rails.application.config.evemonk.image_proxy_url = "https://imageproxy.evemonk.com/" }

      after { Rails.application.config.evemonk.use_image_proxy = false }

      after { Rails.application.config.evemonk.image_proxy_url = "" }

      specify { expect(subject.imageable_url("characters", 1_337_512_245, "portrait", 1024)).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/1337512245/portrait?size=1024") }
    end

    context "when use_image_proxy is false" do
      before { Rails.application.config.evemonk.use_image_proxy = false }

      specify { expect(subject.imageable_url("characters", 1_337_512_245, "portrait", 1024)).to eq("https://images.evetech.net/characters/1337512245/portrait?size=1024") }
    end
  end
end
