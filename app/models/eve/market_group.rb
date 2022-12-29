# frozen_string_literal: true

module Eve
  class MarketGroup < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name, :description

    belongs_to :parent_group,
      class_name: "Eve::MarketGroup",
      primary_key: "market_group_id",
      foreign_key: "parent_group_id",
      optional: true

    belongs_to :icon,
      primary_key: "icon_id",
      optional: true

    has_many :types, # rubocop:disable Rails/HasManyOrHasOneDependent
      primary_key: "market_group_id",
      foreign_key: "market_group_id"

    has_many :subgroups, # rubocop:disable Rails/HasManyOrHasOneDependent
      class_name: "Eve::MarketGroup",
      primary_key: "market_group_id",
      foreign_key: "parent_group_id"

    scope :main_groups, -> { where(parent_group_id: nil) }
  end
end
