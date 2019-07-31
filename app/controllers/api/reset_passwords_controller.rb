# frozen_string_literal: true

module Api
  class ResetPasswordsController < BaseController
    skip_before_action :authenticate

    def create
      @form = ResetPasswordForm.new(resource_params)

      skip_authorization

      if @form.save
        render :create
      else
        render :errors, status: :unprocessable_entity
      end
    end

    private

    def resource_params
      params.require(:reset_password)
        .permit(:reset_password_token, :password, :password_confirmation)
    end
  end
end
