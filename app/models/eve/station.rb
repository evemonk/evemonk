# frozen_string_literal: true

module Eve
  class Station < ApplicationRecord
    self.primary_key = "station_id"

    has_paper_trail

    belongs_to :race, optional: true

    belongs_to :type,
      primary_key: "type_id",
      optional: true

    belongs_to :system, optional: true

    has_one :position,
      as: :positionable,
      dependent: :destroy

    # TODO: add this later
    # t.bigint :owner
  end
end
