# frozen_string_literal: true

module Eve
  class Group < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name

    belongs_to :category,
      primary_key: "category_id",
      foreign_key: "category_id",
      optional: true

    has_many :types,
      primary_key: "group_id",
      foreign_key: "group_id"
  end
end
