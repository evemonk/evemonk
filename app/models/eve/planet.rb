# frozen_string_literal: true

module Eve
  class Planet < ApplicationRecord
    has_paper_trail

    belongs_to :system,
      primary_key: "system_id",
      optional: true

    belongs_to :type,
      primary_key: "type_id",
      optional: true

    has_many :moons, # rubocop:disable Rails/HasManyOrHasOneDependent
      primary_key: "planet_id"

    has_many :asteroid_belts, # rubocop:disable Rails/HasManyOrHasOneDependent
      primary_key: "planet_id"

    has_one :position,
      as: :positionable,
      dependent: :destroy
  end
end
