# frozen_string_literal: true

json.total_count @alliances.total_count
json.total_pages @alliances.total_pages
json.current_page @alliances.current_page
json.alliances do
  json.array! @alliances do |alliance|
    json.id alliance.alliance_id
    json.icon alliance.icon
    json.name alliance.name
    json.ticker alliance.ticker
    json.date_founded alliance.date_founded
    json.corporations_count alliance.corporations_count
    json.characters_count alliance.characters_count

    if alliance.creator_corporation
      json.creator_corporation do
        json.id alliance.creator_corporation.corporation_id
        json.description alliance.creator_corporation.description
        json.name alliance.creator_corporation.name
        json.ticker alliance.creator_corporation.ticker
      end
    end

    if alliance.creator
      json.creator do
        json.id alliance.creator.character_id
        json.name alliance.creator.name
        json.description alliance.creator.description
      end
    end

    if alliance.executor_corporation
      json.executor_corporation do
        json.id alliance.executor_corporation.corporation_id
        json.description alliance.executor_corporation.description
        json.name alliance.executor_corporation.name
        json.ticker alliance.executor_corporation.ticker
      end
    end

    if alliance.faction
      json.faction do
        json.id alliance.faction.faction_id
        json.name alliance.faction.name
        json.description alliance.faction.description
      end
    end
  end
end
