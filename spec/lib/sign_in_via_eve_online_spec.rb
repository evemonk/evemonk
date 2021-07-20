# frozen_string_literal: true

require "rails_helper"

describe SignInViaEveOnline do
  it { should be_an(ActionView::Helpers::FormHelper) }

  it { should be_an(ActionView::Helpers::AssetTagHelper) }

  it { should be_an(ActionView::Context) }

  # private methods

  describe "#image_uri" do
    context "without image proxy" do
      let(:image_url) { "https://web.ccpgamescdn.com/eveonlineassets/developers/eve-sso-login-black-large.png" }

      before { Setting.use_image_proxy = false }

      specify { expect(subject.send(:image_uri)).to eq(image_url) }
    end

    context "with image proxy" do
      let(:image_url) { "https://imageproxy.evemonk.com/https://web.ccpgamescdn.com/eveonlineassets/developers/eve-sso-login-black-large.png" }

      before { Setting.use_image_proxy = true }

      specify { expect(subject.send(:image_uri)).to eq(image_url) }
    end
  end
end
