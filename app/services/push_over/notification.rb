# frozen_string_literal: true

module PushOver
  class Notification
    API_URL = "https://api.pushover.net"
    PATH = "/1/messages.json"

    attr_reader :app_token, :user_key, :message, :title

    def initialize(app_token, user_key, message, title: "")
      @app_token = app_token
      @user_key = user_key
      @message = message
      @title = title
    end

    def notify
      connection.post(PATH, data.to_json)
    end

    private

    def data
      {
        token: app_token,
        user: user_key,
        title: title,
        message: message
      }
    end

    def connection
      Faraday.new(url: API_URL, headers: {"Content-Type": "application/json"})
    end
  end
end
