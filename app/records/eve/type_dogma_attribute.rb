# frozen_string_literal: true

module Eve
  class TypeDogmaAttribute < ApplicationRecord
    has_paper_trail

    belongs_to :type,
      primary_key: "type_id",
      foreign_key: "type_id",
      optional: true

    belongs_to :dogma_attribute,
      primary_key: "attribute_id",
      foreign_key: "attribute_id",
      optional: true
  end
end
