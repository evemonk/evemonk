# frozen_string_literal: true

SCOPES = [
  "publicData",
  "esi-wallet.read_character_wallet.v1",
  "esi-characters.read_loyalty.v1",
  "esi-clones.read_implants.v1",
  "esi-clones.read_clones.v1",
  "esi-skills.read_skillqueue.v1",
  "esi-skills.read_skills.v1",
  "esi-assets.read_assets.v1",
  "esi-location.read_location.v1",
  "esi-location.read_online.v1",
  "esi-location.read_ship_type.v1",
  "esi-mail.read_mail.v1",
  "esi-characters.read_standings.v1",
  "esi-characters.read_blueprints.v1",
  "esi-killmails.read_killmails.v1",
  "esi-industry.read_character_jobs.v1",
  "esi-markets.read_character_orders.v1",
  "esi-corporations.read_corporation_membership.v1",
  "esi-calendar.read_calendar_events.v1"
].freeze

OmniAuth.config.full_host = "https://evemonk.com" if Rails.env.production?

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :eve_online_sso,
    Rails.application.config.evemonk.eve_online_sso[:client_id],
    Rails.application.config.evemonk.eve_online_sso[:secret_key],
    scope: SCOPES.join(" ")
end
