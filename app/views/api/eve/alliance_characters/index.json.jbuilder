# frozen_string_literal: true

json.total_count @characters.total_count
json.total_pages @characters.total_pages
json.current_page @characters.current_page
json.characters do
  json.array! @characters do |character|
    json.id character.character_id
    json.icon "https://imageserver.eveonline.com/Character/#{ character.character_id }_512.jpg"
    json.alliance_id character.alliance_id
    json.ancestry_id character.ancestry_id
    json.birthday character.birthday&.iso8601
    json.bloodline_id character.bloodline_id
    json.corporation_id character.corporation_id
    json.description character.description
    json.faction_id character.faction_id
    if character.faction
      json.faction do
        json.id character.faction.faction_id
        json.name character.faction.name
        json.description character.faction.description
      end
    end
    json.gender character.gender
    json.name character.name
    json.race_id character.race_id
    json.security_status character.security_status.to_s
  end
end
