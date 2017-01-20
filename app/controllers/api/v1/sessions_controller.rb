module Api
  module V1
    class SessionsController < BaseController
      private

      def resource
        @session ||= Session.find(params[:id])
      end

      def collection
        @sessions ||= policy_scope(Session).order(created_at: :asc)
                                           .page(params[:page])
      end
    end
  end
end
