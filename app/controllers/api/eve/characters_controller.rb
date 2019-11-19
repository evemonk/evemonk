# frozen_string_literal: true

module Api
  module Eve
    class CharactersController < BaseController
      skip_before_action :authenticate

      def index
        @characters = ::Eve::CharactersSearcher
          .new(params[:q], policy_scope(::Eve::Character))
          .search
          .page(params[:page])
          .decorate
      end

      def show
        @character = policy_scope(::Eve::Character)
          .find_by!(character_id: params[:id])
          .decorate
      end
    end
  end
end
