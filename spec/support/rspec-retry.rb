# frozen_string_literal: true

# https://github.com/NoRedInk/rspec-retry/pull/123
require "rspec/retry"

RSpec.configure do |config|
  # show retry status in spec process
  config.verbose_retry = true

  # show exception that triggers a retry if verbose_retry is set to true
  config.display_try_failure_messages = true
end
