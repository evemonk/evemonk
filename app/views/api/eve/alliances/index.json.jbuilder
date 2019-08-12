# frozen_string_literal: true

json.total_count @alliances.total_count
json.total_pages @alliances.total_pages
json.current_page @alliances.current_page
json.alliances do
  json.array! @alliances do |alliance|
    json.id alliance.alliance_id
    json.icon do
      json.tiny alliance.icon_tiny
      json.small alliance.icon_small
      json.medium alliance.icon_medium
    end
    json.creator_corporation_id alliance.creator_corporation_id
    json.creator_id alliance.creator_id
    json.date_founded alliance.date_founded
    json.executor_corporation_id alliance.executor_corporation_id
    json.faction_id alliance.faction_id
    json.name alliance.name
    json.ticker alliance.ticker
    json.corporations_count alliance.corporations_count
    json.characters_count alliance.characters_count

    if alliance.creator_corporation
      json.partial! partial: "api/eve/shared/creator_corporation",
                    locals: {creator_corporation: alliance.creator_corporation}
    end

    if alliance.creator
      json.partial! partial: "api/eve/shared/creator",
                    locals: {creator: alliance.creator}
    end

    if alliance.executor_corporation
      json.partial! partial: "api/eve/shared/executor_corporation",
                    locals: {executor_corporation: alliance.executor_corporation}
    end

    if alliance.faction
      json.partial! partial: "api/eve/shared/faction",
                    locals: {faction: alliance.faction}
    end
  end
end
