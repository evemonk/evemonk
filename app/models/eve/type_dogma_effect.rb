# frozen_string_literal: true

module Eve
  class TypeDogmaEffect < ApplicationRecord
    belongs_to :type, optional: true

    # TODO: effect_id
  end
end
