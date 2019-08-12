# frozen_string_literal: true

json.creator do
  json.id creator.character_id
  json.icon do
    json.tiny creator.icon_tiny
    json.small creator.icon_small
    json.medium creator.icon_medium
    json.large creator.icon_large
    json.huge creator.icon_huge
    json.gigantic creator.icon_gigantic
  end
  json.alliance_id creator.alliance_id
  json.ancestry_id creator.ancestry_id
  json.birthday creator.birthday
  json.bloodline_id creator.bloodline_id
  json.corporation_id creator.corporation_id
  json.description creator.description
  json.faction_id creator.faction_id
  json.gender creator.gender
  json.name creator.name
  json.race_id creator.race_id
  json.security_status creator.security_status
  json.title creator.title
end
