# frozen_string_literal: true

class UserResetPasswordMailer < ApplicationMailer
  def email
    @user = params[:user]
    mail(to: @user.email, subject: "Reset password at evemonk.com")
  end
end
