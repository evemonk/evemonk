module Api
  module V1
    class ProfilesController < BaseController
      def show
        skip_authorization

        render json: current_user, serializer: UserSerializer, include: []
      end
    end
  end
end
