# frozen_string_literal: true

class CharacterBlueprintDecorator < ApplicationDecorator
  decorates_associations :character, :blueprint

  def original?
    object.quantity == -1
  end

  def bpo?
    original?
  end

  def copy?
    object.quantity == -2
  end

  def bpc?
    copy?
  end

  def stacked?
    object.quantity > 0
  end

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
end
