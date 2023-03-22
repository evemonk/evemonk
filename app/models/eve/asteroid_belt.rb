# frozen_string_literal: true

module Eve
  class AsteroidBelt < ApplicationRecord
    self.primary_key = "asteroid_belt_id"

    belongs_to :system, optional: true

    belongs_to :planet, optional: true

    has_one :position, as: :positionable, dependent: :destroy
  end
end
