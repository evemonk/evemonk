# frozen_string_literal: true

module Api
  class SignInsController < BaseController
    skip_before_action :authenticate!

    def create
      build_resource

      resource.save!
    end

    private

    def build_resource
      @sign_in = Api::SignIn.new(resource_params)
    end

    def resource
      @sign_in
    end

    def resource_params
      params.require(:sign_in).permit(:email, :password, :name, :device, :device_token)
    end
  end
end
