# frozen_string_literal: true

# https://stackoverflow.com/a/55333591
class HumanTime
  SECONDS_IN_DAY = 24 * 60 * 60
  SECONDS_IN_HOUR = 60 * 60
  SECONDS_IN_MINUTE = 60

  attr_reader :seconds, :parsed

  def initialize(seconds)
    @seconds = seconds
    @parsed = false
  end

  def long_formatted
    return if @seconds.blank?

    parse unless parsed

    output = ""
    output += I18n.t("human_time.days", count: @days) if @days.positive?
    output += I18n.t("human_time.hours", count: @hours) if @hours.positive?
    output += I18n.t("human_time.minutes", count: @minutes) if @minutes.positive?
    output += I18n.t("human_time.seconds", count: @seconds) if @seconds.positive?
    output.strip
  end

  def short_formatted
    return if @seconds.blank?

    parse unless parsed

    output = ""
    output += "#{@days}d " if @days.positive?
    output += "#{@hours}h " if @hours.positive?
    output += "#{@minutes}m " if @minutes.positive?
    output += "#{@seconds}s " if @seconds.positive?
    output.strip
  end

  def very_short_formatted
    short_formatted.split[0..1].join(" ")
  end

  private

  def parse
    @days = @seconds / SECONDS_IN_DAY

    if @days.positive?
      @seconds %= SECONDS_IN_DAY
    end

    @hours = @seconds / SECONDS_IN_HOUR

    if @hours.positive?
      @seconds %= SECONDS_IN_HOUR
    end

    @minutes = @seconds / SECONDS_IN_MINUTE

    @seconds %= SECONDS_IN_MINUTE if @minutes.positive?

    @parsed = true
  end
end
