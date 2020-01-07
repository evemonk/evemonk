# frozen_string_literal: true

module Eve
  class Station < ApplicationRecord
    has_paper_trail

    has_one :position, as: :positionable, dependent: :destroy

    # t.bigint :owner
    # t.bigint :race_id
    # t.bigint :system_id
    # t.bigint :type_id
  end
end
