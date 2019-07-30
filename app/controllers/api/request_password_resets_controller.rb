# frozen_string_literal: true

module Api
  class RequestPasswordResetsController < BaseController
    skip_before_action :authenticate

    def create
      @form = RequestResetPasswordForm.new(resource_params)

      skip_authorization

      if @form.save
        head :ok
      else
        render :errors, status: :unprocessable_entity
      end
    end

    private

    def resource_params
      params.require(:request_password_reset)
        .permit(:email)
    end
  end
end
