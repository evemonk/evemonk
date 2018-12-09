# frozen_string_literal: true

module Api
  class SignOutsController < BaseController
    def destroy
      form = SignOutForm.new(request)

      form.destroy

      skip_authorization

      head :no_content
    end
  end
end
