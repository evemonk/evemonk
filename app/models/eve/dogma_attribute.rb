# frozen_string_literal: true

module Eve
  class DogmaAttribute < ApplicationRecord
    belongs_to :unit,
      primary_key: "unit_id",
      optional: true

    # has_many :eve_type_dogma_attributes, :class_name => 'Eve::TypeDogmaAttribute'

    scope :published, -> { where(published: true) }
  end
end
