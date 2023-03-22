# frozen_string_literal: true

module Eve
  class Moon < ApplicationRecord
    self.primary_key = "moon_id"

    belongs_to :system, optional: true

    belongs_to :planet, optional: true

    has_one :position, as: :positionable, dependent: :destroy
  end
end
