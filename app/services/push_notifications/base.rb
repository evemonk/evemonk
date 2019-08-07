# frozen_string_literal: true

module PushNotifications
  class Base
    attr_reader :device, :device_token, :notifications_count

    def initialize(device, device_token, notifications_count)
      @device = device
      @device_token = device_token
      @notifications_count = notifications_count
    end

    # TODO: add android support
    def execute!
      notification.app = app

      notification.device_token = device_token

      notification.alert = alert

      notification.badge = badge

      notification.save!
    end

    private

    # TODO: add android support
    def notification
      return @notification if @notification

      case device
      when "ios"
        @notification = Rpush::Apns::Notification.new
      # when 'android'
      #   @notification = Rpush::Gcm::Notification.new
      else
        raise NotImplementedError
      end
    end

    # TODO: add android support
    def app
      case device
      when "ios"
        Rpush::Apns::App.find_by_name(device)
      # when 'android'
      #   Rpush::Gcm::App.find_by_name(device)
      else
        raise NotImplementedError
      end
    end

    def alert
      raise NotImplementedError
    end

    def badge
      notifications_count
    end
  end
end
