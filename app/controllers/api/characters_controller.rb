# frozen_string_literal: true

module Api
  class CharactersController < BaseController
    respond_to :json

    def index
      characters = policy_scope(Character).order(created_at: :asc)
                                          .page(params[:page])

      respond_with(CharacterDecorator.decorate_collection(characters))
    end

    def show
      character = Character.find(params[:id])

      authorize(character)

      respond_with(CharacterDecorator.new(character))
    end

    def destroy
      character = Character.find(params[:id])

      authorize(character)

      character.destroy!

      head :no_content
    end
  end
end
