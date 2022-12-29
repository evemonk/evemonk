# frozen_string_literal: true

module Eve
  class Bloodline < ApplicationRecord
    self.primary_key = "bloodline_id"

    extend Mobility

    has_paper_trail

    translates :name, :description

    belongs_to :corporation, optional: true

    belongs_to :race, optional: true

    belongs_to :ship_type,
      class_name: "Eve::Ship",
      foreign_key: "ship_type_id",
      primary_key: "type_id",
      optional: true

    has_many :ancestries # rubocop:disable Rails/HasManyOrHasOneDependent
  end
end
