# frozen_string_literal: true

require "rails_helper"

describe Setting do
  it { should be_a(RailsSettings::Base) }

  describe ".eve_online_sso_client_id" do
    let(:eve_online_sso_client_id) { double }

    before { expect(ENV).to receive(:fetch).with("EVE_ONLINE_SSO_CLIENT_ID", nil).and_return(eve_online_sso_client_id) }

    specify { expect(described_class.eve_online_sso_client_id).to eq(eve_online_sso_client_id) }
  end

  describe ".eve_online_sso_secret_key" do
    let(:eve_online_sso_secret_key) { double }

    before { expect(ENV).to receive(:fetch).with("EVE_ONLINE_SSO_SECRET_KEY", nil).and_return(eve_online_sso_secret_key) }

    specify { expect(described_class.eve_online_sso_secret_key).to eq(eve_online_sso_secret_key) }
  end

  describe ".use_image_proxy" do
    specify { expect(described_class.use_image_proxy).to eq(true) }
  end

  describe ".image_proxy_url" do
    specify { expect(described_class.image_proxy_url).to eq("https://imageproxy.evemonk.com/") }
  end

  describe ".use_google_search_console" do
    specify { expect(described_class.use_google_search_console).to eq(false) }
  end

  describe ".google_site_verification_token" do
    specify { expect(described_class.google_site_verification_token).to eq(nil) }
  end

  describe ".use_plausible_evemonk" do
    specify { expect(described_class.use_plausible_evemonk).to eq(false) }
  end

  describe ".enabled_assets" do
    specify { expect(described_class.enabled_assets).to eq(false) }
  end

  describe ".enabled_mails" do
    specify { expect(described_class.enabled_mails).to eq(false) }
  end

  describe ".enabled_neural_map_available" do
    specify { expect(described_class.enabled_neural_map_available).to eq(false) }
  end

  describe ".enabled_standings" do
    specify { expect(described_class.enabled_standings).to eq(false) }
  end

  describe ".enabled_wallet_journal" do
    specify { expect(described_class.enabled_wallet_journal).to eq(false) }
  end

  describe ".enabled_wallet_transactions" do
    specify { expect(described_class.enabled_wallet_transactions).to eq(false) }
  end

  describe ".enabled_industry_jobs" do
    specify { expect(described_class.enabled_industry_jobs).to eq(false) }
  end

  describe ".enabled_character_orders" do
    specify { expect(described_class.enabled_character_orders).to eq(false) }
  end

  describe ".manufacturing_jobs" do
    specify { expect(described_class.manufacturing_jobs).to eq(false) }
  end
end
