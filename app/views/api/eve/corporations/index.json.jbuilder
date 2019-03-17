# frozen_string_literal: true

json.total_count @corporations.total_count
json.total_pages @corporations.total_pages
json.current_page @corporations.current_page
json.corporations do
  json.array! @corporations do |corporation|
    json.id corporation.corporation_id
    json.icon "https://imageserver.eveonline.com/Corporation/#{ corporation.corporation_id }_256.png"
    json.date_founded corporation.date_founded.iso8601
    json.name corporation.name
    json.member_count corporation.member_count
    json.ticker corporation.ticker
  end
end
