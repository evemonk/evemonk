# frozen_string_literal: true

class CharacterBlueprintDecorator < ApplicationDecorator
  decorates_associations :character, :blueprint, :location
end
