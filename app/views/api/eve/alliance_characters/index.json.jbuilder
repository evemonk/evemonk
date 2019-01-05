# frozen_string_literal: true

json.total_count @characters.total_count
json.total_pages @characters.total_pages
json.current_page @characters.current_page
json.characters do
  json.array! @characters do |character|
    json.id character.character_id
    json.icon "https://imageserver.eveonline.com/Character/#{ character.character_id }_512.jpg"
    json.birthday character.birthday.iso8601
    json.description character.description
    json.gender character.gender
    json.name character.name
    json.security_status character.security_status.to_s

    # if character.ancestry
    #   json.ancestry do
    #     json.id character.ancestry.ancestry_id
    #     json.bloodline_id character.ancestry.bloodline_id
    #     json.description character.ancestry.description
    #     json.icon_id character.ancestry.icon_id
    #     json.name character.ancestry.name
    #     json.short_description character.ancestry.short_description
    #   end
    # end

    # json.bloodline_id character.bloodline_id
    # json.corporation_id character.corporation_id
    # if character.faction
    #   json.faction do
    #     json.id character.faction.faction_id
    #     json.name character.faction.name
    #     json.description character.faction.description
    #   end
    # end
    # json.race_id character.race_id
  end
end
