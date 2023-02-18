# frozen_string_literal: true

module Eve
  class System < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name

    belongs_to :constellation, optional: true

    belongs_to :star, optional: true

    has_many :stargates # rubocop:disable Rails/HasManyOrHasOneDependent

    has_many :planets # rubocop:disable Rails/HasManyOrHasOneDependent

    has_many :moons # rubocop:disable Rails/HasManyOrHasOneDependent

    has_many :stations # rubocop:disable Rails/HasManyOrHasOneDependent

    has_many :asteroid_belts # rubocop:disable Rails/HasManyOrHasOneDependent

    has_one :position, as: :positionable, dependent: :destroy

    def rounded_security_status
      security_status.round(1)
    end
  end
end
