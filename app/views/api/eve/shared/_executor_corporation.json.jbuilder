# frozen_string_literal: true

json.executor_corporation do
  json.id executor_corporation.corporation_id
  json.icon do
    json.tiny executor_corporation.icon_tiny
    json.small executor_corporation.icon_small
    json.medium executor_corporation.icon_medium
    json.large executor_corporation.icon_large
  end
  json.name executor_corporation.name
  json.description executor_corporation.description
  json.ticker executor_corporation.ticker
  json.date_founded executor_corporation.date_founded
  json.url executor_corporation.corporation_url
  json.member_count executor_corporation.member_count
  json.shares executor_corporation.shares
  json.tax_rate executor_corporation.tax_rate
  json.alliance_id executor_corporation.alliance_id
  json.ceo_id executor_corporation.ceo_id
  json.creator_id executor_corporation.creator_id
  json.faction_id executor_corporation.faction_id
  json.home_station_id executor_corporation.home_station_id
  json.war_eligible executor_corporation.war_eligible
end
