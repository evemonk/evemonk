# frozen_string_literal: true

class CharactersController < ApplicationController
  def index
    @characters = policy_scope(Character)
      .includes(:alliance, :corporation)
      .order(created_at: :asc)
      .page(params[:page])
      .decorate
  end

  def show
    @character = Character.eager_load(:race, :bloodline, :ancestry, :faction, :alliance, :corporation)
      .find_by!(character_id: params[:id])
      .decorate

    authorize(@character)
  end

  def destroy
    # character = Character.find_by!(character_id: params[:id])
    #
    # authorize(character)
    #
    # character.destroy!
    #
    # head :no_content
  end
end
