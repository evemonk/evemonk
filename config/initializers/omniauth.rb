# frozen_string_literal: true
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :eve_online_sso, ENV['EVE_ONLINE_SSO_CLIENT_ID'], ENV['EVE_ONLINE_SSO_SECRET_KEY'], scope: 'esi-wallet.read_character_wallet.v1 esi-characters.read_loyalty.v1 esi-skills.read_skillqueue.v1 esi-skills.read_skills.v1 esi-assets.read_assets.v1'
end
