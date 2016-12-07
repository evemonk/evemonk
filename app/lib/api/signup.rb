module Api
  class Signup
    attr_reader :params, :secure_token

    def initialize(params = {})
      @params = params
    end

    def save!
      raise ActiveModel::StrictValidationFailed unless user.valid?

      build_secure_token

      user.save!
    end

    def decorate
      secure_token.decorate
    end

    def user
      @user ||= User.new(params)
    end

    def errors
      user.errors
    end

    def build_secure_token
      @secure_token ||= user.secure_tokens.build
    end
  end
end
