# frozen_string_literal: true

module Api
  class CharactersController < BaseController
    def show
      character = Character.find(params[:id])

      authorize(character)

      render json: CharacterSerializer.new(character).serialized_json
    end

    def index
      characters = policy_scope(Character).order(created_at: :asc)
                                          .page(params[:page])

      options = {}

      options[:meta] = { total: characters.count }

      render json: CharacterSerializer.new(characters, options).serialized_json
    end
  end
end
