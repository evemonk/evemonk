# frozen_string_literal: true

class TrainingQueueTotalTime
  attr_reader :skillqueues

  def initialize(skillqueues)
    @skillqueues = skillqueues
  end

  def total_time
    seconds = 0

    skillqueues.each do |skillqueue|
      seconds += if skillqueue.start_date.past?
        skillqueue.finish_date.to_i - Time.zone.now.to_i
      else
        skillqueue.finish_date.to_i - skillqueue.start_date.to_i
      end
    end

    HumanTime.new(seconds).short_formatted
  end
end
