# frozen_string_literal: true

class CharacterImplantDecorator < ApplicationDecorator
  decorates_associations :character, :implant
end
