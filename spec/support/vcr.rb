# frozen_string_literal: true

VCR.configure do |c|
  # skipcq: RB-RL1022
  c.cassette_library_dir = Rails.root.join("spec", "cassettes")
  c.hook_into :webmock
  c.ignore_localhost = true
  c.ignore_hosts("chromedriver.storage.googleapis.com",
    "github.com/mozilla/geckodriver/releases",
    "selenium-release.storage.googleapis.com",
    "developer.microsoft.com/en-us/microsoft-edge/tools/webdriver")
end
