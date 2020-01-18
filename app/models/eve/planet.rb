# frozen_string_literal: true

module Eve
  class Planet < ApplicationRecord
    has_paper_trail

    # t.bigint "system_id"
    # t.bigint "type_id"

    has_one :position, as: :positionable, dependent: :destroy
  end
end
