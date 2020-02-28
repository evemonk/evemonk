# frozen_string_literal: true

class Setting < RailsSettings::Base
  field :eve_online_sso_client_id, default: ENV["EVE_ONLINE_SSO_CLIENT_ID"], readonly: true

  field :eve_online_sso_secret_key, default: ENV["EVE_ONLINE_SSO_SECRET_KEY"], readonly: true

  field :use_image_proxy, type: :boolean, default: false

  field :image_proxy_url, default: "https://imageproxy.evemonk.com/"

  field :use_google_analytics, type: :boolean, default: false

  field :google_analytics_id, default: ENV["GOOGLE_ANALYTICS_ID"], readonly: true

  field :use_google_search_console, type: :boolean, default: false

  field :google_site_verification_token

  field :use_gauges, type: :boolean, default: false

  field :gauges_data_site_id, default: ENV["GAUGES_DATA_SITE_ID"], readonly: true

  field :enabled_assets, type: :boolean, default: false

  field :enabled_skillqueue, type: :boolean, default: false

  field :enabled_skills, type: :boolean, default: false

  field :enabled_mails, type: :boolean, default: false

  field :enabled_neural_map_available, type: :boolean, default: false

  field :enabled_standings, type: :boolean, default: false

  field :enabled_wallet_journal, type: :boolean, default: false

  field :enabled_wallet_transactions, type: :boolean, default: false

  field :enabled_agents, type: :boolean, default: true
end
