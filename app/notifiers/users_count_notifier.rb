# frozen_string_literal: true

# To deliver this notification:
#
# UsersCountNotifier.with(message: "Test notification").deliver(User.first)

class UsersCountNotifier < ApplicationNotifier
  deliver_by :slack do |config|
    config.url = -> { Rails.application.config.evemonk.slack[:updates_webhook_channel_url] }
    config.json = -> do
      {
        text: params[:message]
      }
    end
  end

  required_param :message
end
