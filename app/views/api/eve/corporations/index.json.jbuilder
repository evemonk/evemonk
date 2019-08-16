# frozen_string_literal: true

json.total_count @corporations.total_count
json.total_pages @corporations.total_pages
json.current_page @corporations.current_page
json.corporations do
  json.array! @corporations do |corporation|
    json.id corporation.corporation_id
    json.icon do
      json.tiny corporation.icon_tiny
      json.small corporation.icon_small
      json.medium corporation.icon_medium
      json.large corporation.icon_large
    end
    json.alliance_id corporation.alliance_id
    json.ceo_id corporation.ceo_id
    json.creator_id corporation.creator_id
    json.date_founded corporation.date_founded
    json.description corporation.description
    json.faction_id corporation.faction_id
    json.home_station_id corporation.home_station_id
    json.member_count corporation.member_count
    json.name corporation.name
    json.shares corporation.shares
    json.tax_rate corporation.tax_rate
    json.ticker corporation.ticker
    json.corporation_url corporation.corporation_url
    json.war_eligible corporation.war_eligible
  end
end
