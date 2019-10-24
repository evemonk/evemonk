# frozen_string_literal: true

class CharacterSkillDecorator < ApplicationDecorator
  decorates_associations :character, :skill
end
