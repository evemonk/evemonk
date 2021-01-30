# frozen_string_literal: true

class CharacterAssetDecorator < ApplicationDecorator
  decorates_associations :character, :type, :location
end
