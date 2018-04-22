# frozen_string_literal: true

module Api
  class SignIn
    include ActiveModel::Validations

    attr_accessor :email, :password

    attr_reader :name, :device_type, :device_token, :session

    validates :email, presence: true

    validates :password, presence: true

    validate :user_presence

    validate :user_password

    delegate :decorate, to: :session

    def initialize(params = {})
      @email = params[:email]
      @password = params[:password]
      @name = params[:name]
      @device_type = params[:device_type]
      @device_token = params[:device_token]
    end

    def save
      return false if !valid?

      # TODO: add this
      # PushNotifications::NewSignIn.new(device, device_token, user.notifications_count).execute!

      create_session!
    end

    private

    def user
      @user ||= User.where('LOWER(email) = LOWER(?)', email).first
    end

    def user_presence
      errors.add(:base, 'Email and/or password is invalid') unless user
    end

    def user_password
      return unless user

      errors.add(:base, 'Email and/or password is invalid') unless user.authenticate(password)
    end

    def create_session!
      @session ||= user.sessions.create!(name: name, device_type: device_type, device_token: device_token)
    end
  end
end
