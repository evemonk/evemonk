# frozen_string_literal: true

require "rails_helper"

describe ApplicationHelper do
  describe "#sign_in_via_eve_online" do
    let(:image_tag) { double }

    let(:image_url) { "" }

    before do
      #
      # image_tag("#{Setting.image_proxy_url if Setting.use_image_proxy}#{image_uri}",
      #           alt: "Sign in via EVE Online")
      #
      expect(helper).to receive(:image_tag).with(image_url, alt: "Sign in via EVE Online")
        .and_return(image_tag)
    end

    before do
      #
      # link_to(image_tag, "/auth/eve_online_sso", method: :post)
      #
      expect(helper).to receive(:link_to).with(image_tag, "/auth/eve_online_sso", method: :post)
    end

    context "without image proxy" do
      let(:image_url) { "https://web.ccpgamescdn.com/eveonlineassets/developers/eve-sso-login-black-large.png" }

      before { Setting.use_image_proxy = false }

      specify { expect { helper.sign_in_via_eve_online }.not_to raise_error }
    end

    context "with image proxy" do
      let(:image_url) { "https://imageproxy.evemonk.com/https://web.ccpgamescdn.com/eveonlineassets/developers/eve-sso-login-black-large.png" }

      before { Setting.use_image_proxy = true }

      specify { expect { helper.sign_in_via_eve_online }.not_to raise_error }
    end
  end
end
