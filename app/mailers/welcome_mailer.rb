# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  def email
    @user = params[:user]
    mail(to: @user.email_address, subject: default_i18n_subject)
  end
end
