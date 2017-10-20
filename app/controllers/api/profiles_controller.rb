# frozen_string_literal: true
module Api
  class ProfilesController < BaseController
    private

    def show; end

    def resource
      current_user
    end
  end
end
