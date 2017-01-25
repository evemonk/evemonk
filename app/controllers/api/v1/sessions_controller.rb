module Api
  module V1
    class SessionsController < BaseController
      def index
        sessions = policy_scope(Session).order(created_at: :asc)
                                         .page(params[:page])

        render json: sessions, each_serializer: SessionSerializer,
                               include: [],
                               fields: [:id, :name, :device, :created_at, :updated_at],
                               root: 'collection', meta: meta_pagination(sessions)
      end

      def destroy
        session = Session.find(params[:id])

        authorize(session)

        session.destroy!

        head :ok
      end
    end
  end
end
