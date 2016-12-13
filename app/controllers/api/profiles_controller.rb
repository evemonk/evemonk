module Api
  class ProfilesController < BaseController
    private

    def resource
      @profile ||= current_user
    end
  end
end
