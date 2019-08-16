# frozen_string_literal: true

json.creator_corporation do
  json.id creator_corporation.corporation_id
  json.icon do
    json.tiny creator_corporation.icon_tiny
    json.small creator_corporation.icon_small
    json.medium creator_corporation.icon_medium
    json.large creator_corporation.icon_large
  end
  json.name creator_corporation.name
  json.description creator_corporation.description
  json.ticker creator_corporation.ticker
  json.date_founded creator_corporation.date_founded
  json.url creator_corporation.corporation_url
  json.member_count creator_corporation.member_count
  json.shares creator_corporation.shares
  json.tax_rate creator_corporation.tax_rate
  json.alliance_id creator_corporation.alliance_id
  json.ceo_id creator_corporation.ceo_id
  json.creator_id creator_corporation.creator_id
  json.faction_id creator_corporation.faction_id
  json.home_station_id creator_corporation.home_station_id
  json.war_eligible creator_corporation.war_eligible
end
