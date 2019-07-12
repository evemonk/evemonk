# frozen_string_literal: true

json.ancestry do
  json.id ancestry.ancestry_id
  json.bloodline_id ancestry.bloodline_id
  json.name ancestry.name
  json.short_description ancestry.short_description
  json.description ancestry.description
  json.icon_id ancestry.icon_id
end
