# frozen_string_literal: true

json.total_count @corporations.total_count
json.total_pages @corporations.total_pages
json.current_page @corporations.current_page
json.corporations do
  json.array! @corporations do |corporation|
    json.id corporation.corporation_id
    json.icon "http://imageserver.eveonline.com/Corporation/#{ corporation.corporation_id }_256.png"
  end
end
