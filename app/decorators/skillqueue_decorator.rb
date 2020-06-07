# frozen_string_literal: true

class SkillqueueDecorator < ApplicationDecorator
  LEVELS = {1 => "I", 2 => "II", 3 => "III", 4 => "IV", 5 => "V"}.freeze

  decorates_associations :character, :skill

  def finished_level
    LEVELS.fetch(object.finished_level)
  end

  # def time_left
  #   seconds = if start_date.past?
  #     finish_date.to_i - Time.zone.now.to_i
  #   else
  #     finish_date.to_i - start_date.to_i
  #   end
  #
  #   HumanTime.new(seconds).very_short_formatted
  # end
end
