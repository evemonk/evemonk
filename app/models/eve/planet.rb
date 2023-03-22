# frozen_string_literal: true

module Eve
  class Planet < ApplicationRecord
    self.primary_key = "planet_id"

    belongs_to :system, optional: true

    belongs_to :type, optional: true

    has_many :moons # rubocop:disable Rails/HasManyOrHasOneDependent

    has_many :asteroid_belts # rubocop:disable Rails/HasManyOrHasOneDependent

    has_one :position, as: :positionable, dependent: :destroy
  end
end
