# frozen_string_literal: true

module Api
  class SessionsController < BaseController
    def index
      @sessions = current_user.sessions
        .order(created_at: :asc)
        .page(params[:page])
    end

    def destroy
      session = current_user.sessions.find(params[:id])

      session.destroy!

      head :no_content
    end
  end
end
