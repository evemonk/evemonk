# frozen_string_literal: true

module Api
  class SignUpForm
    include ActiveModel::Model

    attr_accessor :email, :password, :password_confirmation

    validates :email, presence: true

    validates :password, presence: true

    validates :password_confirmation, presence: true

    validates :password, confirmation: true

    delegate :id, :token, to: :session

    def save
      return false unless valid?

      ActiveRecord::Base.transaction do
        user.save!

        session.save!
      end
    rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
      errors.add(:email, I18n.t("errors.messages.taken"))

      false
    end

    private

    def user
      @user ||= User.new(email: email,
                         password: password,
                         password_confirmation: password_confirmation)
    end

    def session
      @session ||= user.sessions.build
    end
  end
end
