# frozen_string_literal: true

json.alliance do
  json.id alliance.alliance_id
  json.icon do
    json.tiny alliance.icon_tiny
    json.small alliance.icon_small
    json.medium alliance.icon_medium
  end
  json.creator_corporation_id alliance.creator_corporation_id
  json.creator_id alliance.creator_id
  json.date_founded alliance.date_founded
  json.executor_corporation_id alliance.executor_corporation_id
  json.faction_id alliance.faction_id
  json.name alliance.name
  json.ticker alliance.ticker
  json.corporations_count alliance.corporations_count
  json.characters_count alliance.characters_count
end
