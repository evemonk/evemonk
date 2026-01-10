# frozen_string_literal: true

class PasswordsMailer < ApplicationMailer
  # @param user [User]
  def reset(user)
    @user = user

    mail subject: "Reset your password", to: user.email_address
  end
end
