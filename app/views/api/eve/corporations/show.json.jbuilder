# frozen_string_literal: true

json.corporation do
  json.id @corporation.corporation_id
  json.icon @corporation.icon
  json.date_founded @corporation.date_founded
  json.name @corporation.name
  json.description @corporation.description
  json.member_count @corporation.member_count
  json.ticker @corporation.ticker
end
