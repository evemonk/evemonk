# frozen_string_literal: true

module Eve
  class Constellation < ApplicationRecord
    self.primary_key = "constellation_id"

    extend Mobility

    has_paper_trail

    translates :name

    belongs_to :region, optional: true

    has_many :systems # rubocop:disable Rails/HasManyOrHasOneDependent

    has_one :position,
      as: :positionable,
      dependent: :destroy
  end
end
