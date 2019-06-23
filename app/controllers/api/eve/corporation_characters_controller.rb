# frozen_string_literal: true

module Api
  module Eve
    class CorporationCharactersController < BaseController
      skip_before_action :authenticate

      def index
        # @alliance = policy_scope(::Eve::Alliance).find_by!(alliance_id: params[:alliance_id])
        #
        # @characters = policy_scope(::Eve::Character).where(alliance: @alliance)
        #                   .includes(:alliance,
        #                             :ancestry,
        #                             :bloodline,
        #                             :corporation,
        #                             :faction,
        #                             :race)
        #                   .page(params[:page])
      end
    end
  end
end
