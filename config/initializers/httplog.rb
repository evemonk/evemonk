# frozen_string_literal: true

HttpLog.configure do |config|
  # Enable or disable all logging
  config.enabled = Rails.env.development?

  # Tweak which parts of the HTTP cycle to log...
  config.log_connect = true
  config.log_request = true
  config.log_headers = true
  config.log_data = true
  config.log_status = true
  config.log_response = true
  config.log_benchmark = true
end
