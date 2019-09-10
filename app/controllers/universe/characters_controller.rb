# frozen_string_literal: true

module Universe
  class CharactersController < ApplicationController
    def index
      @characters = ::Eve::CharactersSearcher
        .new(params[:q], policy_scope(::Eve::Character))
        .search
        .page(params[:page])
        .decorate
    end

    def show
      @character = policy_scope(::Eve::Character)
        .includes(character_corporation_histories: :corporation)
        .find_by!(character_id: params[:id])
        .decorate

      skip_authorization
    end
  end
end
