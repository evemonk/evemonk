# frozen_string_literal: true

class CharacterOrderDecorator < ApplicationDecorator
  include LocationableDecorator

  decorates_associations :character, :type, :region
end
