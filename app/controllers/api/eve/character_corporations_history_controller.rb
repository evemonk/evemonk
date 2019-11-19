# frozen_string_literal: true

module Api
  module Eve
    class CharacterCorporationsHistoryController < BaseController
      skip_before_action :authenticate

      def index
        @history = ::Eve::CharacterCorporationHistory
          .includes(:corporation)
          .where(character_id: params[:character_id])
          .order(record_id: :desc)
          .page(params[:page])
          .decorate
      end
    end
  end
end
