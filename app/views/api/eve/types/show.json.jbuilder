# frozen_string_literal: true

json.type do
  json.id @type.type_id
  json.capacity @type.capacity
  json.description @type.description
  # dogma_attributes
  # dogma_effects
  json.graphic_id @type.graphic_id
  json.group_id @type.group_id
  json.icon_id @type.icon_id
  json.market_group_id @type.market_group_id
  json.mass @type.mass
  json.name @type.name
  json.packaged_volume @type.packaged_volume
  json.portion_size @type.portion_size
  json.published @type.published
  json.radius @type.radius
  json.type_id @type.type_id
  json.volume @type.volume
end
