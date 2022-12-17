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

    def value_with_unit
      case dogma_attribute.unit.unit_name
      when "attributePoints"
        "#{value.to_i} points"
      when "Slot"
        "Slot #{value.to_i}"
      when "Level"
        "Level #{value.to_i}"
      when "Volume"
        "#{value.to_i} &#13221;".html_safe
      else
        "#{value.to_i} #{dogma_attribute.unit.unit_name}"
      end
    end
  end
end
