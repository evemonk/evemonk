# frozen_string_literal: true

module Api
  class CharactersController < BaseController
    def index
      @characters = policy_scope(Character).order(created_at: :asc)
                                           .page(params[:page])
    end

    def show
      @character = Character.find(params[:id])

      authorize(@character)
    end

    def destroy
      character = Character.find(params[:id])

      authorize(character)

      character.destroy!

      head :no_content
    end
  end
end
