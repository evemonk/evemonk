# frozen_string_literal: true

module Eve
  class TypeDogmaAttribute < ApplicationRecord
    belongs_to :type, primary_key: :type_id, foreign_key: :type_id

    # TODO: attribute_id
  end
end
