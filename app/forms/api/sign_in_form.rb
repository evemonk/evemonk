# frozen_string_literal: true

module Api
  class SignInForm
    include ActiveModel::Model

    attr_accessor :email, :password, :name, :device_type, :device_token

    validates :email, presence: true

    validates :password, presence: true

    validate :user_presence

    validate :user_password

    delegate :id, :token, to: :session

    def save
      return false unless valid?

      # TODO: add this
      # PushNotifications::NewSignIn.new(device, device_token, user.notifications_count).execute!
      # Notifications::NewSignInMailer

      session.save!
    end

    def user
      @user ||= User.where("LOWER(email) = LOWER(?)", email).first
    end

    def user_presence
      return if errors.any?

      errors.add(:base, "Email and/or password is invalid") unless user
    end

    def user_password
      return if errors.any?

      errors.add(:base, "Email and/or password is invalid") if user && !user.authenticate(password)
    end

    def session
      @session ||= user.sessions.build(name: name,
                                       device_type: device_type,
                                       device_token: device_token)
    end
  end
end
