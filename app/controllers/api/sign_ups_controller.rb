# frozen_string_literal: true

module Api
  class SignUpsController < BaseController
    skip_before_action :authenticate

    def create
      @form = SignUpForm.new(sign_up_params)

      if @form.save
        render :create
      else
        render :errors, status: :unprocessable_entity
      end
    end

    private

    def sign_up_params
      params.require(:sign_up).permit(:email, :password, :password_confirmation)
    end
  end
end
