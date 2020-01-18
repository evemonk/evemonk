# frozen_string_literal: true

module Eve
  class Star < ApplicationRecord
    has_paper_trail

    # belongs_to :solar_system_id

    belongs_to :type,
      primary_key: "type_id",
      foreign_key: "type_id",
      optional: true
  end
end
