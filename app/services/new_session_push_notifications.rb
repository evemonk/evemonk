class NewSessionPushNotifications
  attr_reader :user, :exclude_token

  def initialize(user, exclude_token)
    @user = user
    @exclude_token = exclude_token
  end

  def execute!
    user.sessions.where.not(device_token: nil).where.not(device_token: exclude_token).each do |session|
      PushNotifications::NewSignIn.new(session.device, session.device_token, user.notifications_count).execute!
    end
  end
end
