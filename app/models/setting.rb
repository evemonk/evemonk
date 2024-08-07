# frozen_string_literal: true

class Setting < RailsSettings::Base
  field :use_image_proxy, type: :boolean, default: true

  field :image_proxy_url, default: "https://imageproxy.evemonk.com/"

  field :use_google_search_console, type: :boolean, default: false

  field :google_site_verification_token

  field :use_fathom_evemonk, type: :boolean, default: false

  field :enabled_assets, type: :boolean, default: false

  field :enabled_mails, type: :boolean, default: false

  field :enabled_neural_map_available, type: :boolean, default: false

  field :enabled_standings, type: :boolean, default: false

  field :enabled_wallet_journal, type: :boolean, default: false

  field :enabled_wallet_transactions, type: :boolean, default: false

  field :enabled_industry_jobs, type: :boolean, default: false

  field :enabled_character_orders, type: :boolean, default: false

  field :manufacturing_jobs, type: :boolean, default: false
end
