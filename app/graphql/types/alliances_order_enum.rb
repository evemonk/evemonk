# frozen_string_literal: true

module Types
  class AlliancesOrderEnum < BaseEnum
    description "Alliances order by enum"

    value "CORPORATIONS_COUNT_DESC", "Order by corporations_count desc"
    value "CORPORATIONS_COUNT_ASC", "Order by corporations_count asc"
    value "CHARACTERS_COUNT_DESC", "Order by characters_count desc"
    value "CHARACTERS_COUNT_ASC", "Order by characters_count asc"
    value "NONE", "Order by default (by ID)"
  end
end
