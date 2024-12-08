# frozen_string_literal: true

module Universe
  module Corporations
    class CharactersController < ApplicationController
      skip_before_action :authenticate_user!

      def index
        @corporation = policy_scope(Eve::Corporation).find(params[:corporation_id])

        @characters = policy_scope(Eve::Character)
          .where(corporation: @corporation)
          .order(:name)

        render layout: false
      end
    end
  end
end
