# frozen_string_literal: true

json.total_count @characters.total_count
json.total_pages @characters.total_pages
json.current_page @characters.current_page
json.characters do
  json.array! @characters do |character|
    json.id character.character_id
    json.icon "https://imageserver.eveonline.com/Character/#{ character.character_id }_512.jpg"
    json.name character.name
  end
end
