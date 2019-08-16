# frozen_string_literal: true

module Eve
  class Type < ApplicationRecord
    searchkick

    has_many :type_dogma_attributes,
             primary_key: :type_id,
             foreign_key: :type_id,
             dependent: :destroy

    has_many :type_dogma_effects,
             primary_key: :type_id,
             foreign_key: :type_id,
             dependent: :destroy

    def search_data
      {
        name: name,
      }
    end
  end
end
