module Api
  class Session
    include ActiveModel::Validations

    attr_reader :email, :password, :name, :secure_token

    validate :user_presence

    validate :user_password

    def initialize(params = {})
      @email = params[:email]
      @password = params[:password]
      @name = params[:name]
    end

    def save!
      raise ActiveModel::StrictValidationFailed unless valid?

      create_secure_token!
    end

    def decorate(*args)
      secure_token.decorate(*args)
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

    def create_secure_token!
      @secure_token ||= user.secure_tokens.create!(name: name)
    end
  end
end
