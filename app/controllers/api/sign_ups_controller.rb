module Api
  class SignUpsController < BaseController
    skip_before_action :authenticate

    def create
      build_resource

      resource.save!

      skip_authorization
    end

    private

    def build_resource
      @signup = Api::SignUp.new(resource_params)
    end

    def resource
      @signup
    end

    def resource_params
      params.permit(:email, :password, :password_confirmation)
    end
  end
end
