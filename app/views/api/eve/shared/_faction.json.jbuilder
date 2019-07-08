# frozen_string_literal: true

json.faction do
  json.id faction.faction_id
  json.corporation_id faction.corporation_id
  json.name faction.name
  json.description faction.description
  json.militia_corporation_id faction.militia_corporation_id
  json.solar_system_id faction.solar_system_id
  json.station_count faction.station_count
  json.station_system_count faction.station_system_count
  json.size_factor faction.size_factor
  json.is_unique faction.is_unique
end
