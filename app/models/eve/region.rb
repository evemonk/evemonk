# frozen_string_literal: true

module Eve
  class Region < ApplicationRecord
    self.primary_key = "region_id"

    extend Mobility

    translates :name, :description

    has_many :constellations # rubocop:disable Rails/HasManyOrHasOneDependent

    has_many :contracts # rubocop:disable Rails/HasManyOrHasOneDependent
  end
end
