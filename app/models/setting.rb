# frozen_string_literal: true

class Setting < RailsSettings::Base
  field :eve_online_sso_client_id, default: ENV["EVE_ONLINE_SSO_CLIENT_ID"], readonly: true

  field :eve_online_sso_secret_key, default: ENV["EVE_ONLINE_SSO_SECRET_KEY"], readonly: true

  field :use_image_proxy, type: :boolean, default: true

  field :image_proxy_url, default: "https://imageproxy.evemonk.com/"

  field :use_google_search_console, type: :boolean, default: false

  field :google_site_verification_token

  field :enabled_assets, type: :boolean, default: false

  field :enabled_skillqueue, type: :boolean, default: false

  field :enabled_skills, type: :boolean, default: false

  field :enabled_mails, type: :boolean, default: false

  field :enabled_neural_map_available, type: :boolean, default: false

  field :enabled_standings, type: :boolean, default: false

  field :enabled_wallet_journal, type: :boolean, default: false

  field :enabled_wallet_transactions, type: :boolean, default: false

  field :enabled_blueprints, type: :boolean, default: false

  field :enabled_industry_jobs, type: :boolean, default: false

  field :enabled_character_orders, type: :boolean, default: false

  field :manufacturing_jobs, type: :boolean, default: false
end
