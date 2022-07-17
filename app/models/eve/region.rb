# frozen_string_literal: true

module Eve
  class Region < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name, :description

    has_many :constellations # rubocop:disable Rails/HasManyOrHasOneDependent

    has_many :contracts # rubocop:disable Rails/HasManyOrHasOneDependent
  end
end
