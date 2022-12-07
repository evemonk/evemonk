# frozen_string_literal: true

class Setting < RailsSettings::Base
  field :eve_online_sso_client_id, default: ENV.fetch("EVE_ONLINE_SSO_CLIENT_ID", nil), readonly: true

  field :eve_online_sso_secret_key, default: ENV.fetch("EVE_ONLINE_SSO_SECRET_KEY", nil), readonly: true

  field :use_image_proxy, type: :boolean, default: true

  field :image_proxy_url, default: "https://imageproxy.evemonk.com/"

  field :use_google_search_console, type: :boolean, default: false

  field :google_site_verification_token

  field :use_plausible_evemonk, type: :boolean, default: false

  field :enabled_assets, type: :boolean, default: false

  # TODO: remove dead code
  field :enabled_skillqueue, type: :boolean, default: false

  field :enabled_mails, type: :boolean, default: false

  field :enabled_neural_map_available, type: :boolean, default: false

  field :enabled_standings, type: :boolean, default: false

  field :enabled_wallet_journal, type: :boolean, default: false

  field :enabled_wallet_transactions, type: :boolean, default: false

  field :enabled_industry_jobs, type: :boolean, default: false

  field :enabled_character_orders, type: :boolean, default: false

  field :manufacturing_jobs, type: :boolean, default: false
end
