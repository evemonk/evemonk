module Api
  module V1
    class SignOutsController < BaseController
      def destroy
        Api::SignOut.new(request).destroy!

        skip_authorization

        head :ok
      end
    end
  end
end
