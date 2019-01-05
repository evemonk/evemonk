# frozen_string_literal: true

module Api
  module Eve
    class AllianceCharactersController < BaseController
      skip_before_action :authenticate

      def index
        skip_policy_scope

        @alliance = ::Eve::Alliance.find_by!(alliance_id: params[:alliance_id])

        @characters = ::Eve::Character.where(alliance: @alliance)
                                      .includes(:alliance,
                                                :ancestry,
                                                :bloodline,
                                                :corporation,
                                                :faction,
                                                :race)
                                      .page(params[:page])
      end
    end
  end
end
