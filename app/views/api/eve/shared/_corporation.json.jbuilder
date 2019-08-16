# frozen_string_literal: true

json.corporation do
  json.id corporation.corporation_id
  json.icon do
    json.tiny corporation.icon_tiny
    json.small corporation.icon_small
    json.medium corporation.icon_medium
    json.large corporation.icon_large
  end
  json.name corporation.name
  json.description corporation.description
  json.ticker corporation.ticker
  json.date_founded corporation.date_founded
  json.url corporation.corporation_url
  json.member_count corporation.member_count
  json.shares corporation.shares
  json.tax_rate corporation.tax_rate
  json.alliance_id corporation.alliance_id
  json.ceo_id corporation.ceo_id
  json.creator_id corporation.creator_id
  json.faction_id corporation.faction_id
  json.home_station_id corporation.home_station_id
  json.war_eligible corporation.war_eligible
end
