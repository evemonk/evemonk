module Api
  class SignUpsController < BaseController
    skip_before_action :authenticate!

    private

    def build_resource
      @sign_up = Api::SignUp.new(resource_params)
    end

    def resource
      @sign_up
    end

    def resource_params
      params.permit(:email, :password, :password_confirmation)
    end
  end
end
