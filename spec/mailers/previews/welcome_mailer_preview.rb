# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/welcome_mailer
class WelcomeMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/welcome_mailer/email
  def email
    user = FactoryBot.create(:user)

    WelcomeMailer.with(user: user).email
  end
end
