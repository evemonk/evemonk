# frozen_string_literal: true

json.total_count @types.total_count
json.total_pages @types.total_pages
json.current_page @types.current_page
json.characters do
  json.array! @types do |type|
    json.id type.type_id
    json.capacity type.capacity
    json.description type.description
    # dogma_attributes
    # dogma_effects
    json.graphic_id type.graphic_id
    json.group_id type.group_id
    json.icon_id type.icon_id
    json.market_group_id type.market_group_id
    json.mass type.mass
    json.name type.name
    json.packaged_volume type.packaged_volume
    json.portion_size type.portion_size
    json.published type.published
    json.radius type.radius
    json.volume type.volume
  end
end
