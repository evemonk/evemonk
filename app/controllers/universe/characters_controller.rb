# frozen_string_literal: true

module Universe
  class CharactersController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      collection = Eve::SearchCharactersQuery
        .new(params[:q])
        .query

      @pagy, @characters = pagy(collection)
    end

    def show
      @character = ::Eve::Character
        .includes(:alliance, :corporation)
        .find_by!(character_id: params[:id])

      @character_corporation_histories = Eve::CharacterCorporationHistory.where(character_id: @character.character_id)
        .includes(:corporation)
        .order(start_date: :desc)
    end
  end
end
