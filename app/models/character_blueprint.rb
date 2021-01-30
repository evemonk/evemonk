# frozen_string_literal: true

class CharacterBlueprint < ApplicationRecord
  include Locationable

  belongs_to :character

  belongs_to :blueprint,
    class_name: "Eve::Blueprint",
    primary_key: "type_id",
    foreign_key: "type_id",
    optional: true

  # BPO -- Blue Print Original
  def bpo?
    quantity == -1
  end

  # BPC -- Blue Print Copy
  def bpc?
    quantity == -2
  end

  def stacked?
    quantity.positive?
  end

  def material_efficiency_formatted
    return if stacked?

    if material_efficiency.zero?
      "#{material_efficiency} %"
    else
      "+#{material_efficiency} %"
    end
  end

  def time_efficiency_formatted
    return if stacked?

    if time_efficiency.zero?
      "#{time_efficiency} %"
    else
      "+#{time_efficiency} %"
    end
  end
end
