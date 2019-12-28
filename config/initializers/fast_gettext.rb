# frozen_string_literal: true

FastGettext.add_text_domain "app", path: "locale", type: :po
FastGettext.default_text_domain = "app"
FastGettext.default_available_locales = ["en", "de", "fr", "ja", "ru", "zh", "ko"]
