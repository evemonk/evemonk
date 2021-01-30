# frozen_string_literal: true

require "rails_helper"

describe ApplicationRecord do
  it { expect(described_class.abstract_class).to eq(true) }

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
end
