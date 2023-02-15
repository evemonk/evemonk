# frozen_string_literal: true

module Eve
  class Bloodline < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name, :description

    belongs_to :corporation, optional: true

    belongs_to :race, optional: true

    belongs_to :ship_type, class_name: "Eve::Ship", optional: true

    has_many :ancestries # rubocop:disable Rails/HasManyOrHasOneDependent
  end
end
