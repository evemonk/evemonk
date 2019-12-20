# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/devise/mailer
class Devise::MailerPreview < ActionMailer::Preview
  def confirmation_instructions
    user = FactoryBot.create(:user)

    token = SecureRandom.base58

    Devise::Mailer.confirmation_instructions(user, token)
  end

  def reset_password_instructions
    user = FactoryBot.create(:user)

    token = SecureRandom.base58

    Devise::Mailer.reset_password_instructions(user, token)
  end

  # def unlock_instructions
  #   user = FactoryBot.create(:user)
  #
  #   token = SecureRandom.base58
  #
  #   Devise::Mailer.unlock_instructions(user, token)
  # end

  def email_changed
    user = FactoryBot.create(:user)

    Devise::Mailer.email_changed(user)
  end

  def password_change
    user = FactoryBot.create(:user)

    Devise::Mailer.password_change(user)
  end
end
