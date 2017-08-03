module Api
  class SignUp
    attr_reader :params, :session

    delegate :decorate, to: :session

    delegate :errors, to: :user

    def initialize(params = {})
      @params = params
    end

    def save!
      raise ActiveModel::StrictValidationFailed unless user.valid?

      build_session

      user.save!
    rescue ActiveRecord::RecordNotUnique
      user.errors.add(:email, I18n.t('errors.messages.taken'))

      raise ActiveModel::StrictValidationFailed
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
