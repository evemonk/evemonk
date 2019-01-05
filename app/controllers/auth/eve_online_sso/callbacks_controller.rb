# frozen_string_literal: true

module Auth
  module EveOnlineSso
    class CallbacksController < ApplicationController
      def show
        form = Api::EveOnlineForm.new(request)

        form.save!

        redirect_to "/autosignin/#{ form.session.token }"
      end
    end
  end
end
