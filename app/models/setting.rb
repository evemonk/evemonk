# frozen_string_literal: true

class Setting < RailsSettings::Base
  # cache_prefix { 'v1' }

  field :eve_online_sso_client_id, default: ENV["EVE_ONLINE_SSO_CLIENT_ID"], readonly: true

  field :eve_online_sso_secret_key, default: ENV["EVE_ONLINE_SSO_SECRET_KEY"], readonly: true
end
