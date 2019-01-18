# frozen_string_literal: true

json.character do
  json.id @character.character_id
  json.icon "https://imageserver.eveonline.com/Character/#{ @character.character_id }_512.jpg"
  json.name @character.name
end
