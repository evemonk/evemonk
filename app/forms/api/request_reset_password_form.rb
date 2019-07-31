# frozen_string_literal: true

module Api
  class RequestResetPasswordForm
    include ActiveModel::Model

    attr_accessor :email

    validates :email, presence: true

    validate :user_presence

    def save
      return false unless valid?

      user.regenerate_reset_password_token

      notify_user_via_email

      true
    end

    private

    def user
      @user ||= User.where("LOWER(email) = LOWER(?)", email).first
    end

    def user_presence
      return if errors.any?

      errors.add(:email, "Email not found") unless user
    end

    def notify_user_via_email
      UserResetPasswordMailer.with(user: user).email.deliver_later
    end
  end
end
