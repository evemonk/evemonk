# frozen_string_literal: true

require "rails_helper"

RSpec.describe LanguageMapper do
  specify do
    expect(described_class::LANGUAGES).to eq(
      en: "en-us",
      de: "de",
      fr: "fr",
      ja: "ja",
      zh: "zh",
      ko: "ko",
      es: "es"
    )
  end
end
