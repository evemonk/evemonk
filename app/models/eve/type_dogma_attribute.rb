# frozen_string_literal: true

module Eve
  class TypeDogmaAttribute < ApplicationRecord
    has_paper_trail

    belongs_to :type, primary_key: :type_id, foreign_key: :type_id

    # TODO: attribute_id
  end
end
