# frozen_string_literal: true

module Authentication
  def api_sign_in(user = User.new)
    allow(controller).to receive(:authenticate).and_return(user)

    allow(controller).to receive(:current_user).and_return(user)
  end
end

RSpec.configure do |config|
  config.include Authentication, type: :controller
end
