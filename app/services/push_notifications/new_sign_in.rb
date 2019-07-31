# frozen_string_literal: true

module PushNotifications
  class NewSignIn < Base
    private

    def alert
      "New sign-in from Location (IP)"
    end
  end
end
