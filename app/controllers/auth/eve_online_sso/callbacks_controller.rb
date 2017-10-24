# frozen_string_literal: true

module Auth
  module EveOnlineSso
    class CallbacksController < ApplicationController
      def show
        eve_online = Api::EveOnline.new(request)

        eve_online.save!

        cookies['auth_token'] = eve_online.session.token

        redirect_to root_url
      end
    end
  end
end
