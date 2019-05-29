# frozen_string_literal: true

module Eve
  class TypeDogmaEffect < ApplicationRecord
    belongs_to :type, primary_key: :type_id, foreign_key: :type_id

    # TODO: effect_id
  end
end
