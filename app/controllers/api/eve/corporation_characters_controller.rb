# frozen_string_literal: true

module Api
  module Eve
    class CorporationCharactersController < BaseController
      skip_before_action :authenticate

      def index
        corporation = policy_scope(::Eve::Corporation)
          .find_by!(corporation_id: params[:corporation_id])
          .decorate

        @characters = policy_scope(::Eve::Character)
          .where(corporation: corporation)
          .includes(:alliance, :ancestry, :bloodline, :corporation, :faction,
            :race)
          .page(params[:page])
          .decorate
      end
    end
  end
end
