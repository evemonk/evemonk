module Api
  class SignOutsController < BaseController
    def destroy
      Api::SignOut.new(request).destroy!

      head :ok
    end
  end
end
