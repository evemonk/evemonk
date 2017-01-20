module Api
  module V1
    class ProfilesController < BaseController
      private

      def resource
        @profile ||= current_user
      end
    end
  end
end
