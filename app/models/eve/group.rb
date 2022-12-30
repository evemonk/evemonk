# frozen_string_literal: true

module Eve
  class Group < ApplicationRecord
    self.primary_key = "group_id"

    extend Mobility

    has_paper_trail

    translates :name

    belongs_to :category, optional: true

    has_many :types # rubocop:disable Rails/HasManyOrHasOneDependent

    has_many :certificates, # rubocop:disable Rails/HasManyOrHasOneDependent
      primary_key: "group_id",
      foreign_key: "group_id"

    scope :published, -> { where(published: true) }
  end
end
