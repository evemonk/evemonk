# frozen_string_literal: true

module Eve
  class TypeDogmaAttribute < ApplicationRecord
    include ActionView::Helpers::NumberHelper

    has_paper_trail

    belongs_to :type, optional: true

    belongs_to :dogma_attribute,
      primary_key: "attribute_id",
      foreign_key: "attribute_id",
      optional: true

    def value_with_unit
      return value.to_i if dogma_attribute.unit.blank?

      case dogma_attribute.unit.unit_name
      when "attributePoints"
        "#{value.to_i} points"
      when "Slot"
        "Slot #{value.to_i}"
      when "Level"
        "Level #{value.to_i}"
      when "Volume"
        "#{value.to_i} &#13221;".html_safe # rubocop:disable Rails/OutputSafety
      when "Hitpoints"
        "#{number_with_delimiter(value.to_i, delimiter: " ")} HP"
      when "Mass"
        "#{number_with_delimiter(value.to_i, delimiter: " ")} kg"
      when "Percentage"
        "#{value.to_i} %"
      else
        "#{value.to_i} #{dogma_attribute.unit.unit_name}"
      end
    end
  end
end
