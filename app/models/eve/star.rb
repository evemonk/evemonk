# frozen_string_literal: true

module Eve
  class Star < ApplicationRecord
    self.primary_key = "star_id"

    has_paper_trail

    belongs_to :solar_system,
      class_name: "Eve::System",
      primary_key: "system_id",
      foreign_key: "solar_system_id",
      optional: true

    belongs_to :type,
      primary_key: "type_id",
      foreign_key: "type_id",
      optional: true
  end
end
