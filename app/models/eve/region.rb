# frozen_string_literal: true

module Eve
  class Region < ApplicationRecord
    self.primary_key = "region_id"

    extend Mobility

    has_paper_trail

    translates :name, :description

    has_many :constellations

    has_many :contracts
  end
end
