# frozen_string_literal: true

module Api
  module Eve
    class AllianceCorporationsController < BaseController
      skip_before_action :authenticate

      def index
        @corporations = ::Eve::Corporation
          .where(alliance_id: params[:alliance_id])
          .includes(:alliance, :ceo, :creator, :faction)
          .page(params[:page])
          .decorate
      end
    end
  end
end
