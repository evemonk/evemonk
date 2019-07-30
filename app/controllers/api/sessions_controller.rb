# frozen_string_literal: true

module Api
  class SessionsController < BaseController
    def index
      @sessions = policy_scope(Session).order(created_at: :asc)
        .page(params[:page])
    end

    def destroy
      session = Session.find(params[:id])

      authorize(session)

      session.destroy!

      head :no_content
    end
  end
end
