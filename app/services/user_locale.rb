# frozen_string_literal: true

class UserLocale
  LOCALES = {
    "english" => :en,
    "german" => :de,
    "french" => :fr,
    "japanese" => :ja,
    "korean" => :ko
  }.freeze

  attr_reader :language

  def initialize(language)
    @language = language
  end

  def to_locale
    LOCALES.fetch(language) { |_| :en }
  end
end
