# frozen_string_literal: true
module Api
  class SignOutsController < BaseController
    def destroy
      Api::SignOut.new(request).destroy!

      head :ok
    end
  end
end
