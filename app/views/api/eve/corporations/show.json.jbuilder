# frozen_string_literal: true

json.corporation do
  json.id @corporation.corporation_id
  json.icon do
    json.tiny @corporation.icon_tiny
    json.small @corporation.icon_small
    json.medium @corporation.icon_medium
    json.large @corporation.icon_large
  end
  json.alliance_id @corporation.alliance_id
  json.ceo_id @corporation.ceo_id
  json.creator_id @corporation.creator_id
  json.date_founded @corporation.date_founded
  json.description @corporation.description
  json.faction_id @corporation.faction_id
  json.home_station_id @corporation.home_station_id
  json.member_count @corporation.member_count
  json.name @corporation.name
  json.shares @corporation.shares
  json.tax_rate @corporation.tax_rate
  json.ticker @corporation.ticker
  json.corporation_url @corporation.corporation_url
  json.war_eligible @corporation.war_eligible

  if @corporation.alliance
    json.partial! partial: "api/eve/shared/alliance",
                  locals: {alliance: @corporation.alliance}
  end

  if @corporation.ceo
    json.partial! partial: "api/eve/shared/ceo",
                  locals: {ceo: @corporation.ceo}
  end

  if @corporation.creator
    json.partial! partial: "api/eve/shared/creator",
                  locals: {creator: @corporation.creator}
  end

  if @corporation.faction
    json.partial! partial: "api/eve/shared/faction",
                  locals: {faction: @corporation.faction}
  end
end
