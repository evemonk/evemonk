module Api
  class Signup
    attr_reader :params, :session

    def initialize(params = {})
      @params = params
    end

    def save!
      raise ActiveModel::StrictValidationFailed unless user.valid?

      build_session

      user.save!
    end

    def decorate
      session.decorate
    end

    def user
      @user ||= User.new(params)
    end

    def errors
      user.errors
    end

    def build_session
      @session ||= user.sessions.build
    end
  end
end
