# frozen_string_literal: true

class SkillqueueDecorator < ApplicationDecorator
  decorates_associations :character, :skill
end
