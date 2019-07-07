# frozen_string_literal: true

json.total_count @characters.total_count
json.total_pages @characters.total_pages
json.current_page @characters.current_page
json.characters do
  json.array! @characters do |character|
    json.id character.character_id
    json.icon character.icon
    json.name character.name

    if character.alliance
      json.alliance do
        json.id character.alliance.alliance_id
        json.creator_corporation_id character.alliance.creator_corporation_id
        json.creator_id character.alliance.creator_id
        json.date_founded character.alliance.date_founded
        json.executor_corporation_id character.alliance.executor_corporation_id
        json.faction_id character.alliance.faction_id
        json.name character.alliance.name
        json.ticker character.alliance.ticker
      end
    end

    if character.corporation
      json.corporation do
        json.id character.corporation.corporation_id
        json.name character.corporation.name
        json.description character.corporation.description
        json.ticker character.corporation.ticker
        json.date_founded character.corporation.date_founded
        json.url character.corporation.corporation_url
        json.member_count character.corporation.member_count
        json.shares character.corporation.shares
        json.tax_rate character.corporation.tax_rate
        json.alliance_id character.corporation.alliance_id
        json.ceo_id character.corporation.ceo_id
        json.creator_id character.corporation.creator_id
        json.faction_id character.corporation.faction_id
        json.home_station_id character.corporation.home_station_id
      end
    end
  end
end
