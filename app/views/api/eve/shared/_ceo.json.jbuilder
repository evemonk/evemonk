# frozen_string_literal: true

json.ceo do
  json.id ceo.character_id
  json.icon do
    json.tiny ceo.icon_tiny
    json.small ceo.icon_small
    json.medium ceo.icon_medium
    json.large ceo.icon_large
    json.huge ceo.icon_huge
    json.gigantic ceo.icon_gigantic
  end
  json.alliance_id ceo.alliance_id
  json.ancestry_id ceo.ancestry_id
  json.birthday ceo.birthday
  json.bloodline_id ceo.bloodline_id
  json.corporation_id ceo.corporation_id
  json.description ceo.description
  json.faction_id ceo.faction_id
  json.gender ceo.gender
  json.name ceo.name
  json.race_id ceo.race_id
  json.security_status ceo.security_status
  json.title ceo.title
end
