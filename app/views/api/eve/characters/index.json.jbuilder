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
    json.title character.title
  end
end
