# frozen_string_literal: true

module Eve
  class Region < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name, :description

    has_many :constellations, primary_key: "region_id"
  end
end
