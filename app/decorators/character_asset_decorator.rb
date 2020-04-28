# frozen_string_literal: true

class CharacterAssetDecorator < ApplicationDecorator
  include LocationableDecorator

  decorates_associations :character, :type
end
