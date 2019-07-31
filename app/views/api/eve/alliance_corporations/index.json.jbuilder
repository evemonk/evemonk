# frozen_string_literal: true

json.total_count @corporations.total_count
json.total_pages @corporations.total_pages
json.current_page @corporations.current_page
json.corporations do
  json.array! @corporations do |corporation|
    json.id corporation.corporation_id
    json.icon corporation.icon
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

    if corporation.alliance
      json.partial! partial: "api/eve/shared/alliance",
                    locals: {alliance: corporation.alliance}
    end

    if corporation.ceo
      json.partial! partial: "api/eve/shared/ceo",
                    locals: {ceo: corporation.ceo}
    end

    if corporation.creator
      json.partial! partial: "api/eve/shared/creator",
                    locals: {creator: corporation.creator}
    end

    if corporation.faction
      json.partial! partial: "api/eve/shared/faction",
                    locals: {faction: corporation.faction}
    end
  end
end
