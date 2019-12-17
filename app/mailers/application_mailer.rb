# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "robot@evemonk.com"

  layout "mailer"
end
