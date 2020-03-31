# frozen_string_literal: true

# https://stackoverflow.com/a/55333591
class HumanTime
  attr_reader :seconds

  def initialize(seconds)
    @seconds = seconds
  end

  def to_s
    parse

    output = ""
    output += "#{@days} days " if @days > 0
    output += "#{@hours} hours " if @hours > 0
    output += "#{@minutes} minutes " if @minutes > 0
    output += "#{@seconds} seconds " if @seconds > 0
    output
  end

  def parse
    day = 24 * 60 * 60

    @days = @seconds / day

    if @days > 0
      @seconds = @seconds % day
    end

    hour = 60 * 60

    @hours = @seconds / hour

    if @hours > 0
      @seconds = @seconds % hour
    end

    minute = 60

    @minutes = @seconds / minute

    if @minutes > 0
      @seconds = @seconds % minute
    end
  end
end
