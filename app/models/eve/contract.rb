# frozen_string_literal: true

module Eve
  class Contract < ApplicationRecord
    belongs_to :region,
      primary_key: "region_id",
      optional: true
  end
end
