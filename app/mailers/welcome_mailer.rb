# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  def email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome to evemonk.com")
  end
end
