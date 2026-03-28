# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def eve_online_sso
      @user = User.from_omniauth(request.env["omniauth.auth"])

      # service = EveOnlineCallbackService.new(request: request, user: current_user)
      #
      # service.save!

      sign_in_and_redirect @user # sign_in_and_redirect is an OAuth method
    end
  end
end
