# frozen_string_literal: true

class SkillqueueDecorator < ApplicationDecorator
  decorates_associations :character, :skill

  def finished_level
    case object.finished_level
    when 1
      "I"
    when 2
      "II"
    when 3
      "III"
    when 4
      "IV"
    when 5
      "V"
    else
      raise "Unknown finished level"
    end
  end
end
