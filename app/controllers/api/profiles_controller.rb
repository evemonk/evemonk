# frozen_string_literal: true

module Api
  class ProfilesController < BaseController
    def show
      @user = current_user

      skip_authorization
    end
  end
end
