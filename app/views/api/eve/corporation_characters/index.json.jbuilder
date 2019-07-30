# frozen_string_literal: true

json.total_count @characters.total_count
json.total_pages @characters.total_pages
json.current_page @characters.current_page
json.characters do
  json.array! @characters do |character|
    json.id character.character_id
    json.icon character.icon
    json.alliance_id character.alliance_id
    json.ancestry_id character.ancestry_id
    json.birthday character.birthday
    json.bloodline_id character.bloodline_id
    json.corporation_id character.corporation_id
    json.description character.description
    json.faction_id character.faction_id
    json.gender character.gender
    json.name character.name
    json.race_id character.race_id
    json.security_status character.security_status
    json.title character.title

    if character.alliance
      json.partial! partial: "api/eve/shared/alliance",
                    locals: {alliance: character.alliance}
    end

    if character.ancestry
      json.partial! partial: "api/eve/shared/ancestry",
                    locals: {ancestry: character.ancestry}
    end

    if character.bloodline
      json.partial! partial: "api/eve/shared/bloodline",
                    locals: {bloodline: character.bloodline}
    end

    if character.corporation
      json.partial! partial: "api/eve/shared/corporation",
                    locals: {corporation: character.corporation}
    end

    if character.faction
      json.partial! partial: "api/eve/shared/faction",
                    locals: {faction: character.faction}
    end

    if character.race
      json.partial! partial: "api/eve/shared/race",
                    locals: {race: character.race}
    end
  end
end
