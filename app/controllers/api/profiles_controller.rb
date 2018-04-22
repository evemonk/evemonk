# frozen_string_literal: true

module Api
  class ProfilesController < BaseController
    def show
      render json: UserDecorator.new(current_user)
    end
  end
end
