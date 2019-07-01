# frozen_string_literal: true

json.total_count @corporations.total_count
json.total_pages @corporations.total_pages
json.current_page @corporations.current_page
json.corporations do
  json.array! @corporations do |corporation|
    json.id corporation.corporation_id
    json.icon corporation.icon
    json.date_founded corporation.date_founded
    json.name corporation.name
    # json.description corporation.description
    # json.home_station_id corporation.home_station_id
    json.member_count corporation.member_count
    # json.shares corporation.shares
    # json.tax_rate corporation.tax_rate
    json.ticker corporation.ticker
    # json.url corporation.corporation_url
    # json.war_eligible corporation.war_eligible
    #
    # if corporation.ceo
    #
    # end
    #
    # if corporation.creator
    #
    # end
    #
    # if corporation.faction
    #
    # end
  end
end
