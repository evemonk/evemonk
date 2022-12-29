# frozen_string_literal: true

module Eve
  class System < ApplicationRecord
    self.primary_key = "system_id"

    extend Mobility

    has_paper_trail

    translates :name

    belongs_to :constellation,
      primary_key: "constellation_id",
      optional: true

    belongs_to :star, optional: true

    has_many :stargates

    has_many :planets

    has_many :moons

    has_many :stations

    has_many :asteroid_belts

    has_one :position,
      as: :positionable,
      dependent: :destroy

    def rounded_security_status
      security_status.round(1)
    end
  end
end
