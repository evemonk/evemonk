# frozen_string_literal: true

module Api
  class SignOutsController < BaseController
    def destroy
      form = SignOutForm.new(request)

      form.destroy!

      head :no_content
    end
  end
end
