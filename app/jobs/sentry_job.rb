# frozen_string_literal: true

class SentryJob < ApplicationJob
  queue_as :sentry

  def perform(event, hint)
    Sentry.send_event(event, hint)
  end
end
