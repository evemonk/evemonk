module Api
  class SessionsController < BaseController
    skip_before_action :authenticate

    private

    def build_resource
      @resource = Api::Session.new(resource_params)
    end

    def resource
      @resource
    end

    def resource_params
      params.require(:session).permit(:email, :password)
    end
  end
end
