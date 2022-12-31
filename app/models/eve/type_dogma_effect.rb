# frozen_string_literal: true

module Eve
  class TypeDogmaEffect < ApplicationRecord
    has_paper_trail

    belongs_to :type, optional: true

    # TODO: effect_id
  end
end
