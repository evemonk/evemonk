# frozen_string_literal: true

require "rails_helper"

describe SignInViaEveOnline do
  it { should be_an(ActionView::Helpers::FormHelper) }

  it { should be_an(ActionView::Helpers::AssetTagHelper) }

  it { should be_an(ActionView::Context) }

  it { expect(described_class::URL).to eq("/auth/eve_online_sso") }

  describe "#form" do
    let(:form) { described_class.new.form }

    subject { Nokogiri::HTML(form) }

    specify { expect(subject.xpath("//form[@class='sign_in_via_eve_online']").attribute("data-turbo").value).to eq("false") }

    specify { expect(subject.xpath("//form[@class='sign_in_via_eve_online']").attribute("action").value).to eq(described_class::URL) }

    specify { expect(subject.xpath("//form[@class='sign_in_via_eve_online']").attribute("method").value).to eq("post") }

    specify { expect(subject.xpath("//button[@class='sign_in_button']").attribute("type").value).to eq("submit") }

    specify { expect(subject.xpath("//img[@class='sign_in_image']").attribute("src").value).to eq(described_class.new.send(:image_uri)) }

    specify { expect(subject.xpath("//img[@class='sign_in_image']").attribute("alt").value).to eq("Sign in via EVE Online") }
  end

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
