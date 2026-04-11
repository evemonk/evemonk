# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def eve_online_sso
      # binding.pry

      if user_signed_in?

      else
        @user = User.from_omniauth(request.env["omniauth.auth"])

        sign_in_and_redirect @user # sign_in_and_redirect is an OAuth method
      end

      # @user = User.from_omniauth(request.env["omniauth.auth"])

      # service = EveOnlineCallbackService.new(request: request, user: current_user)
      #
      # service.save!

      # sign_in_and_redirect @user # sign_in_and_redirect is an OAuth method
    end

    private

    def service_unavailable_handle
      redirect_to characters_path, alert: t(".service_unavailable")
    end

    def internal_server_error_handle
      redirect_to characters_path, alert: t(".internal_server_error")
    end

    def bad_gateway_handle
      redirect_to characters_path, alert: t(".bad_gateway")
    end

    def timeout_handle
      redirect_to characters_path, alert: t(".timeout")
    end
  end
end
