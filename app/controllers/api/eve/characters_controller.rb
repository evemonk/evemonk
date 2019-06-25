# frozen_string_literal: true

module Api
  module Eve
    class CharactersController < BaseController
      skip_before_action :authenticate

      def index
        @characters = ::Eve::CharactersSearcher.new(params[:q],
                                                    policy_scope(::Eve::Character))
                                               .search
                                               .page(params[:page])
      end

      def show
        @character = ::Eve::Character.find_by!(character_id: params[:id])

        authorize(@character)
      end
    end
  end
end
