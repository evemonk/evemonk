# frozen_string_literal: true

module Eve
  class Constellation < ApplicationRecord
    self.primary_key = "constellation_id"

    extend Mobility

    has_paper_trail

    translates :name

    belongs_to :region,
      primary_key: "region_id",
      optional: true

    has_many :systems

    has_one :position,
      as: :positionable,
      dependent: :destroy
  end
end
