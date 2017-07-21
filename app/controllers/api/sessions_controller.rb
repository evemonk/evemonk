module Api
  class SessionsController < BaseController
    private

    def resource
      @session ||= current_user.sessions.find(params[:id])
    end

    def collection
      @sessions ||= current_user.sessions
                                .order(created_at: :asc)
                                .page(params[:page])
    end
  end
end
