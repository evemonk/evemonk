# frozen_string_literal: true

module Eve
  class Station < ApplicationRecord
    self.primary_key = "station_id"

    belongs_to :race, optional: true

    belongs_to :type, optional: true

    belongs_to :system, optional: true

    has_one :position, as: :positionable, dependent: :destroy

    # TODO: add this later
    # t.bigint :owner
  end
end
