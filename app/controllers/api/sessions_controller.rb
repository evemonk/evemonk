module Api
  class SessionsController < BaseController
    skip_before_action :authenticate, only: :create

    def create
      build_resource

      resource.save!

      skip_authorization
    end

    def destroy
      authorize(secure_token)

      secure_token.destroy!

      head :ok
    end

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
