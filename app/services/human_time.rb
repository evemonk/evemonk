# frozen_string_literal: true

# https://stackoverflow.com/a/55333591
class HumanTime
  SECONDS_IN_DAY = 24 * 60 * 60
  SECONDS_IN_HOUR = 60 * 60
  SECONDS_IN_MINUTE = 60

  attr_reader :seconds

  def initialize(seconds)
    @seconds = seconds
  end

  def to_s
    return if @seconds.blank?

    parse

    output = ""
    output += "#{@days} days " if @days.positive?
    output += "#{@hours} hours " if @hours.positive?
    output += "#{@minutes} minutes " if @minutes.positive?
    output += "#{@seconds} seconds " if @seconds.positive?
    output
  end

  private

  def parse
    @days = @seconds / SECONDS_IN_DAY

    if @days.positive?
      @seconds = @seconds % SECONDS_IN_DAY
    end

    @hours = @seconds / SECONDS_IN_HOUR

    if @hours.positive?
      @seconds = @seconds % SECONDS_IN_HOUR
    end

    @minutes = @seconds / SECONDS_IN_MINUTE

    @seconds = @seconds % SECONDS_IN_MINUTE if @minutes.positive?
  end
end
