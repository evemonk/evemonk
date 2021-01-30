# frozen_string_literal: true

class CharacterBlueprintDecorator < ApplicationDecorator
  decorates_associations :character, :blueprint, :location

  def icon_tiny
    if stacked? || bpo?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bp?size=32"
    elsif bpc?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bpc?size=32"
    end
  end

  def icon_small
    if stacked? || bpo?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bp?size=64"
    elsif bpc?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bpc?size=64"
    end
  end

  # def character_copying_time_formatted
  #   HumanTime.new(CharacterManufacturingCopyTime.new(@character, @blueprint.blueprint.copying_time).manufacturing_copy_time.round).long_formatted
  # end
end
