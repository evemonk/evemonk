# frozen_string_literal: true

module Eve
  class Bloodline < ApplicationRecord
    extend Mobility

    translates :name, :description

    belongs_to :corporation, optional: true

    belongs_to :race, optional: true

    belongs_to :ship, foreign_key: :ship_type_id, class_name: "Eve::Ship", optional: true

    has_many :ancestries # rubocop:disable Rails/HasManyOrHasOneDependent
  end
end
