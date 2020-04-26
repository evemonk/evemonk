# frozen_string_literal: true

json.total_count @items.total_count
json.total_pages @items.total_pages
json.current_page @items.current_page
json.blueprints do
  json.array! @items do |item|
    json.id item.type_id
    json.name item.name
    json.icon item.icon_tiny
  end
end
