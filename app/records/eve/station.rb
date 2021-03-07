# frozen_string_literal: true

module Eve
  class Station < ApplicationRecord
    has_paper_trail

    belongs_to :race,
      primary_key: "race_id",
      optional: true

    belongs_to :type,
      primary_key: "type_id",
      optional: true

    belongs_to :system,
      primary_key: "system_id",
      optional: true

    has_one :position,
      as: :positionable,
      dependent: :destroy

    # TODO: add this later
    # t.bigint :owner
  end
end
