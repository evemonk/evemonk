# frozen_string_literal: true

Authy.api_key = ENV.fetch("AUTHY_API_KEY", nil)
Authy.api_uri = "https://api.authy.com/"
