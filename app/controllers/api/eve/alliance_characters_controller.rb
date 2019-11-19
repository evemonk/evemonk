# frozen_string_literal: true

module Api
  module Eve
    class AllianceCharactersController < BaseController
      skip_before_action :authenticate

      def index
        @characters = ::Eve::Character
          .where(alliance_id: params[:alliance_id])
          .includes(:alliance, :ancestry, :bloodline, :corporation, :faction,
            :race)
          .page(params[:page])
          .decorate
      end
    end
  end
end
