# frozen_string_literal: true

module Api
  class ChangePasswordForm
    include ActiveModel::Model

    attr_accessor :user, :old_password, :password, :password_confirmation,
                  :name, :device_type, :device_token

    validates :old_password, presence: true

    validates :password, presence: true

    validates :password_confirmation, presence: true

    validates :password, confirmation: true

    validate :old_password_validation

    delegate :id, :token, to: :session

    def save
      return false unless valid?

      change_password

      end_all_user_sessions

      session.save!

      # notify_user

      true
    end

    def old_password_validation
      # TODO: only if "password_digest: nil"
      errors.add(:old_password, "Wrong password") unless user.authenticate(old_password)
    end

    # def change_user_oauth_kind_to_regular
    #
    # end

    def change_password
      user.update!(password: password)
    end

    def end_all_user_sessions
      EndAllUserSessions.new(user).execute
    end

    def session
      @session ||= user.sessions.build(name: name,
                                       device_type: device_type,
                                       device_token: device_token)
    end

    # def notify_user
    #   # TODO: write sms/push notification
    # end
  end
end
