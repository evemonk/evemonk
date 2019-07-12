# frozen_string_literal: true

json.bloodline do
  json.id bloodline.bloodline_id
  json.corporation_id bloodline.corporation_id
  json.race_id bloodline.race_id
  json.name bloodline.name
  json.description bloodline.description
  json.charisma bloodline.charisma
  json.intelligence bloodline.intelligence
  json.memory bloodline.memory
  json.perception bloodline.perception
  json.willpower bloodline.willpower
  json.ship_type_id bloodline.ship_type_id
end
