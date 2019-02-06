# frozen_string_literal: true

module Api
  class EndAllUserSessions
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def execute
      user.sessions.destroy_all
    end
  end
end
