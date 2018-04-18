# frozen_string_literal: true

module Api
  class SignUpsController < BaseController
    skip_before_action :authenticate!

    def create
      sign_up = Api::SignUp.new(sign_ups_params)

      if sign_up.save
        render json: SessionDecorator.new(sign_up.session,
                                          context: { with_token: true })
      else
        render json: { errors: sign_up.errors }
      end

    end

    private

    def sign_ups_params
      params.require(:sign_up).permit(:email, :password, :password_confirmation)
    end
  end
end
