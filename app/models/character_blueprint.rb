# frozen_string_literal: true

class CharacterBlueprint < ApplicationRecord
  include Locationable
  include ImageProxy

  RELIC_CATEGORY_ID = 34

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

  def relic?
    blueprint&.group&.category_id == RELIC_CATEGORY_ID
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

  def icon_tiny
    if relic?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/relic?size=32"
    elsif stacked? || bpo?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bp?size=32"
    elsif bpc?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bpc?size=32"
    end
  end

  def icon_small
    if relic?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/relic?size=64"
    elsif stacked? || bpo?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bp?size=64"
    elsif bpc?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bpc?size=64"
    end
  end

  # def character_copying_time_formatted
  #   HumanTime.new(CharacterManufacturingCopyTime.new(@character, @blueprint.blueprint.copying_time).manufacturing_copy_time.round).long_formatted
  # end
end
