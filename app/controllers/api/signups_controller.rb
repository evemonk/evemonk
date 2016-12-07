module Api
  class SignupsController < BaseController
    skip_before_action :authenticate

    def create
      build_resource

      resource.save!

      skip_authorization
    end

    private

    def build_resource
      @signup = Api::Signup.new(resource_params)
    end

    def resource
      @signup
    end

    def resource_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end
