# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_reset_password_mailer
class WelcomeMailerPreview < ActionMailer::Preview
  def email
    user = FactoryBot.create(:user)

    WelcomeMailer.with(user: user).email
  end
end
