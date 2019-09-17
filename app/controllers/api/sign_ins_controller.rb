# frozen_string_literal: true

module Api
  class SignInsController < BaseController
    skip_before_action :authenticate

    def create
      @form = SignInForm.new(sign_in_params)

      skip_authorization

      if @form.save
        render :create
      else
        render :errors, status: :unprocessable_entity
      end
    end

    private

    def sign_in_params
      params.require(:sign_in).permit(:email, :password, :name, :device_type,
        :device_token)
    end
  end
end
