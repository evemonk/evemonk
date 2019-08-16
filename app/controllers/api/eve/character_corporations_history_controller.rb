# frozen_string_literal: true

module Api
  module Eve
    class CharacterCorporationsHistoryController < BaseController
      skip_before_action :authenticate

      def index
        character = policy_scope(::Eve::Character)
          .find_by!(character_id: params[:character_id])
          .decorate

        @history = policy_scope(::Eve::CharacterCorporationHistory)
          .includes(:corporation)
          .where(character: character)
          .order(record_id: :desc)
          .page(params[:page])
          .decorate
      end
    end
  end
end
