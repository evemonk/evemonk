# frozen_string_literal: true

json.total_count @corporations.total_count
json.total_pages @corporations.total_pages
json.current_page @corporations.current_page
json.corporations do
  json.array! @corporations do |corporation|
    json.id corporation.corporation_id
    json.icon corporation.icon
    json.date_founded corporation.date_founded
    json.name corporation.name
    json.description corporation.description
    json.member_count corporation.member_count
    json.ticker corporation.ticker
  end
end
