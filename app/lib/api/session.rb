module Api
  class Session
    include ActiveModel::Validations

    attr_reader :email, :password

    # TODO: spec this
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
      UserDecorator.new(user)
    end

    private

    def user
      @user ||= User.find_by(email: email)
    end

    # TODO: spec this
    def user_presence
      errors.add(:email, 'not found') unless user
    end

    def user_password
      return unless user

      errors.add(:password, 'is invalid') unless user.authenticate(password)
    end
  end
end
