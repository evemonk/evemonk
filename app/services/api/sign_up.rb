module Api
  class SignUp
    attr_reader :params, :session

    delegate :decorate, to: :session, prefix: nil

    delegate :errors, to: :user, prefix: nil

    def initialize(params = {})
      @params = params
    end

    def save!
      raise ActiveModel::StrictValidationFailed unless user.valid?

      build_session

      user.save!
    end

    private

    def user
      @user ||= User.new(params)
    end

    def build_session
      @session ||= user.sessions.build
    end
  end
end
