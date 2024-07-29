# frozen_string_literal: true

module Eve
  class Star < ApplicationRecord
    # TODO: finish migration
    self.primary_key = "star_id"

    belongs_to :solar_system, class_name: "Eve::System", optional: true

    belongs_to :type, optional: true
  end
end
