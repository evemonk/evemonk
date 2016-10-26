module Api
  class Session
    include ActiveModel::Validations

    attr_reader :email, :password

    validate :user_presence

    validate :user_password

    def initialize(params = {})
      @email = params[:email]
      @password = params[:password]
    end

    def save!
      raise ActiveModel::StrictValidationFailed unless valid?

      valid?
    end

    def decorate
      SecureTokenDecorator.new(secure_token)
    end

    private

    def user
      @user ||= User.find_by(email: email)
    end

    def secure_token
      @secure_token ||= user.secure_tokens.create!
    end

    def user_presence
      errors.add(:email, 'not found') unless user
    end

    def user_password
      return unless user

      errors.add(:password, 'is invalid') unless user.authenticate(password)
    end
  end
end
