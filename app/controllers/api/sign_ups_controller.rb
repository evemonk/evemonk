# frozen_string_literal: true

module Api
  class SignUpsController < BaseController
    skip_before_action :authenticate!

    respond_to :json

    def create
      sign_up = Api::SignUp.new(sign_ups_params)

      if sign_up.save
        respond_with(SessionDecorator.new(sign_up.session,
                                          context: { with_token: true }))
      else
        respond_with(sign_up, status: :unprocessable_entity)
      end
    end

    private

    def sign_ups_params
      params.require(:sign_up).permit(:email, :password, :password_confirmation)
    end
  end
end
