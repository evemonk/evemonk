# frozen_string_literal: true

json.total_count @history.total_count
json.total_pages @history.total_pages
json.current_page @history.current_page
json.history do
  json.array! @history do |history|
    json.character_id history.character_id
    json.corporation_id history.corporation_id
    json.is_deleted history.is_deleted
    json.record_id history.record_id
    json.start_date history.start_date.iso8601

    if history.corporation
      json.partial! partial: "api/eve/shared/corporation",
                    locals: {corporation: history.corporation}
    end
  end
end
