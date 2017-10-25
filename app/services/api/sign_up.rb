# frozen_string_literal: true

module Api
  class SignUp
    include ActiveModel::Validations

    attr_reader :email, :password, :password_confirmation, :session

    attr_writer :email, :password

    delegate :decorate, to: :session

    validates :email, presence: true

    validates :password, presence: true

    validates :password, confirmation: true

    def initialize(params)
      @email = params[:email]
      @password = params[:password]
      @password_confirmation = params[:password_confirmation]
    end

    def save!
      raise ActiveModel::StrictValidationFailed unless valid?

      build_session

      user.save!
    rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
      errors.add(:email, I18n.t('errors.messages.taken'))

      raise ActiveModel::StrictValidationFailed
    end

    private

    def user
      @user ||= User.new(email: email,
                         password: password,
                         password_confirmation: password_confirmation)
    end

    def build_session
      @session ||= user.sessions.build
    end
  end
end
