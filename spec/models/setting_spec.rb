# frozen_string_literal: true

require "rails_helper"

RSpec.describe Setting do
  it { expect(subject).to be_a(RailsSettings::Base) }

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

  describe ".use_fathom_evemonk" do
    specify { expect(described_class.use_fathom_evemonk).to eq(false) }
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
