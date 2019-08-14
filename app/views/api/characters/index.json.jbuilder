# frozen_string_literal: true

json.total_count @characters.total_count
json.total_pages @characters.total_pages
json.current_page @characters.current_page
json.characters do
  json.array! @characters do |character|
    json.id character.character_id
    json.icon do
      json.tiny character.icon_tiny
      json.small character.icon_small
      json.medium character.icon_medium
      json.large character.icon_large
      json.huge character.icon_huge
      json.gigantic character.icon_gigantic
    end
    json.name character.name

    if character.alliance
      json.alliance do
        json.id character.alliance.alliance_id
        json.icon do
          json.tiny character.alliance.icon_tiny
          json.small character.alliance.icon_small
          json.medium character.alliance.icon_medium
        end
        json.creator_corporation_id character.alliance.creator_corporation_id
        json.creator_id character.alliance.creator_id
        json.date_founded character.alliance.date_founded
        json.executor_corporation_id character.alliance.executor_corporation_id
        json.faction_id character.alliance.faction_id
        json.name character.alliance.name
        json.ticker character.alliance.ticker
        json.corporations_count character.alliance.corporations_count
        json.characters_count character.alliance.characters_count
      end
    end

    if character.corporation
      json.corporation do
        json.id character.corporation.corporation_id
        json.icon do
          json.tiny character.corporation.icon_tiny
          json.small character.corporation.icon_small
          json.medium character.corporation.icon_medium
          json.large character.corporation.icon_large
        end
        json.alliance_id character.corporation.alliance_id
        json.ceo_id character.corporation.ceo_id
        json.creator_id character.corporation.creator_id
        json.date_founded character.corporation.date_founded
        json.description character.corporation.description
        json.faction_id character.corporation.faction_id
        json.home_station_id character.corporation.home_station_id
        json.member_count character.corporation.member_count
        json.name character.corporation.name
        json.shares character.corporation.shares
        json.tax_rate character.corporation.tax_rate
        json.ticker character.corporation.ticker
        json.corporation_url character.corporation.corporation_url
        json.war_eligible character.corporation.war_eligible
      end
    end
  end
end
