module Api
  class ProfilesController < BaseController
    private

    def resource
      current_user
    end
  end
end
