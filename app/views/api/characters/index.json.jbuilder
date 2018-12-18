# frozen_string_literal: true

json.total_count @characters.total_count
json.total_pages @characters.total_pages
json.current_page @characters.current_page
json.characters do
  json.array! @characters do |character|
    json.id character.id
    json.character_id character.character_id
    json.alliance_id character.alliance_id
    json.ancestry_id character.ancestry_id
    json.birthday character.birthday&.iso8601
    json.bloodline_id character.bloodline_id
    json.corporation_id character.corporation_id
    json.description character.description
    json.faction_id character.faction_id
    json.gender character.gender
    json.name character.name
    json.race_id character.race_id
    json.security_status character.security_status
    json.scopes character.scopes
    json.token_type character.token_type
    json.icon "https://imageserver.eveonline.com/Character/#{ character.character_id }_512.jpg"
  end
end
