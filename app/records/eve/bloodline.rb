# frozen_string_literal: true

module Eve
  class Bloodline < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name, :description

    belongs_to :corporation,
      primary_key: "corporation_id",
      optional: true

    belongs_to :race,
      primary_key: "race_id",
      optional: true

    belongs_to :ship_type,
      class_name: "Eve::Ship",
      foreign_key: "ship_type_id",
      primary_key: "type_id",
      optional: true

    has_many :ancestries,
      primary_key: "bloodline_id"
  end
end
