# frozen_string_literal: true

module Universe
  class CharactersController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @characters = ::Eve::CharactersSearcher
        .new(params[:q])
        .search
        .page(params[:page])
        .decorate
    end

    def show
      @character = ::Eve::Character
        .includes(character_corporation_histories: :corporation)
        .find_by!(character_id: params[:id])
        .decorate
    end
  end
end
