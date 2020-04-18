# frozen_string_literal: true

json.total_count @blueprints.total_count
json.total_pages @blueprints.total_pages
json.current_page @blueprints.current_page
json.blueprints do
  json.array! @blueprints do |blueprint|
    json.id blueprint.type_id
    json.name blueprint.name
    json.icon blueprint.icon_tiny
  end
end
