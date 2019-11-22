# frozen_string_literal: true

module Api
  module Eve
    class CorporationCharactersController < BaseController
      skip_before_action :authenticate

      def index
        @characters = ::Eve::Character
          .where(corporation_id: params[:corporation_id])
          .includes(:alliance, :ancestry, :bloodline, :corporation, :faction, :race)
          .page(params[:page])
          .decorate
      end
    end
  end
end
