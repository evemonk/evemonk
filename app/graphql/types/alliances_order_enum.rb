# frozen_string_literal: true

module Types
  class AlliancesOrderEnum < BaseEnum
    description "Alliances order by enum"

    value "CORPORATIONS_COUNT_DESC", "corporations_count by descending order"
    value "CORPORATIONS_COUNT_ASC", "corporations_count by ascending order"
    value "CHARACTERS_COUNT_DESC", "characters_count by ascending order"
    value "CHARACTERS_COUNT_ASC", "characters_count by ascending order"
    value "NONE", "None: order by default (by ID)"
  end
end
