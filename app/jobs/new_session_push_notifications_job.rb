class NewSessionPushNotificationsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    NewSessionPushNotifications.new(user).execute!
  end
end
