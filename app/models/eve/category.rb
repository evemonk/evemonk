# frozen_string_literal: true

module Eve
  class Category < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name

    has_many :groups # rubocop:disable Rails/HasManyOrHasOneDependent

    has_many :types, through: :groups

    scope :published, -> { where(published: true) }
  end
end
