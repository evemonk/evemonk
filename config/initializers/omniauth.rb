# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :eve_online_sso,
           Setting.eve_online_sso_client_id,
           Setting.eve_online_sso_secret_key,
           scope: "esi-wallet.read_character_wallet.v1 esi-characters.read_loyalty.v1 esi-skills.read_skillqueue.v1 esi-skills.read_skills.v1 esi-assets.read_assets.v1"
end
