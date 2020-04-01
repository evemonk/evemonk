# frozen_string_literal: true

module Eve
  class TypeDogmaEffect < ApplicationRecord
    has_paper_trail

    belongs_to :type,
      primary_key: "type_id",
      foreign_key: "type_id",
      optional: true

    # TODO: effect_id
  end
end
