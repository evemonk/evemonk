# frozen_string_literal: true

json.character do
  json.id @character.character_id
  json.icon "https://imageserver.eveonline.com/Character/#{ @character.character_id }_512.jpg"
  json.name @character.name
  if @character.alliance
    json.alliance do
      json.id @character.alliance.alliance_id
      json.name @character.alliance.name
    end
  end
end
