# frozen_string_literal: true

json.corporation do
  json.id @corporation.corporation_id
  json.icon @corporation.icon
  json.date_founded @corporation.date_founded
  json.name @corporation.name
  json.description @corporation.description
  json.member_count @corporation.member_count
  json.ticker @corporation.ticker

  if @corporation.alliance
    json.partial! partial: 'api/eve/shared/alliance', locals: { alliance: @corporation.alliance }
  end

  if @corporation.ceo
    json.partial! partial: 'api/eve/shared/ceo', locals: { ceo: @corporation.ceo }
  end

  if @corporation.creator
    json.partial! partial: 'api/eve/shared/creator', locals: { creator: @corporation.creator }
  end

  if @corporation.faction
    json.partial! partial: 'api/eve/shared/faction', locals: { faction: @corporation.faction }
  end
end
