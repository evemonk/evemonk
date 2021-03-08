# frozen_string_literal: true

module Eve
  class RaceRecord < ApplicationRecord
    self.table_name = "eve_races"

    # has_paper_trail
    #
    # belongs_to :faction,
    #   primary_key: "faction_id",
    #   optional: true
    #
    # has_many :bloodlines,
    #   primary_key: "race_id"
    #
    # has_many :stations,
    #   primary_key: "race_id"
  end
end
