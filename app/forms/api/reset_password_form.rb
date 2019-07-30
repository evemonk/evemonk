# frozen_string_literal: true

module Api
  class ResetPasswordForm
    include ActiveModel::Model

    attr_accessor :reset_password_token, :password, :password_confirmation

    validates :reset_password_token, presence: true

    validates :password, presence: true

    validates :password_confirmation, presence: true

    validates :password, confirmation: true

    validate :user_presence

    delegate :id, :token, to: :session

    def save
      return false unless valid?

      change_password

      end_all_user_sessions

      session.save!

      true
    end

    private

    def user
      @user ||= User.find_by(reset_password_token: reset_password_token)
    end

    def user_presence
      return if errors.any?

      errors.add(:base, "Reset password token not found") unless user
    end

    def change_password
      user.update!(password: password)
    end

    def session
      # TODO: add session name, device type and device token
      @session ||= user.sessions.build
    end

    def end_all_user_sessions
      EndAllUserSessions.new(user).execute
    end
  end
end
