# frozen_string_literal: true

module Api
  class SessionsController < BaseController
    def index
      @sessions = current_user.sessions
        .order(created_at: :asc)
        .page(params[:page])
    end

    def destroy
      current_user.sessions.find(params[:id]).destroy!

      head :no_content
    end
  end
end
