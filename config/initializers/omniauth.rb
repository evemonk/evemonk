# frozen_string_literal: true

OmniAuth.config.full_host = "https://evemonk.com" if Rails.env.production?

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :eve_online_sso,
    Rails.application.config.evemonk.eve_online_sso[:client_id],
    Rails.application.config.evemonk.eve_online_sso[:secret_key],
    scope: "publicData"
end
