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

    belongs_to :star,
      primary_key: "star_id",
      optional: true

    has_many :stargates,
      primary_key: "system_id"

    has_many :planets,
      primary_key: "system_id"

    has_many :moons,
      primary_key: "system_id"

    has_many :stations,
      primary_key: "system_id"

    has_many :asteroid_belts,
      primary_key: "system_id"

    has_one :position,
      as: :positionable,
      dependent: :destroy

    def rounded_security_status
      security_status.round(1)
    end
  end
end
