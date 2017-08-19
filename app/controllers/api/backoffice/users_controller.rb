module Api
  module Backoffice
    class UsersController < BaseController
      private

      def collection
        @users ||= User.page(params[:page])
      end

      def resource
        @user = User.find(params[:id])
      end
    end
  end
end
