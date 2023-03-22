# frozen_string_literal: true

module Eve
  class MarketGroup < ApplicationRecord
    self.primary_key = "market_group_id"

    extend Mobility

    translates :name, :description

    belongs_to :parent_group, class_name: "Eve::MarketGroup", optional: true

    belongs_to :icon, optional: true

    has_many :types # rubocop:disable Rails/HasManyOrHasOneDependent

    has_many :subgroups, # rubocop:disable Rails/HasManyOrHasOneDependent
      class_name: "Eve::MarketGroup",
      foreign_key: "parent_group_id"

    scope :main_groups, -> { where(parent_group_id: nil) }
  end
end
