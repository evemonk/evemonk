# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("ACTION_MAILER_FROM", nil)

  layout "mailer"
end
