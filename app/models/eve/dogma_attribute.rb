# frozen_string_literal: true

module Eve
  class DogmaAttribute < ApplicationRecord
    belongs_to :unit, optional: true

    # has_many :eve_type_dogma_attributes, :class_name => 'Eve::TypeDogmaAttribute'

    belongs_to :icon,
      primary_key: "icon_id",
      optional: true

    scope :published, -> { where(published: true) }
  end
end
