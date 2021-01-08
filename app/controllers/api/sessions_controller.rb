# frozen_string_literal: true

module Api
  class SessionsController < BaseController
    def destroy
      current_user.sessions.find(params[:id]).destroy!

      head :no_content
    end
  end
end
