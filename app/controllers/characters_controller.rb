# frozen_string_literal: true

class CharactersController < ApplicationController
  def index
    @characters = current_user.characters
      .includes(:alliance, :corporation)
      .order(created_at: :asc)
      .page(params[:page])
      .decorate
  end

  def show
    @character = current_user.characters
      .eager_load(:race, :bloodline, :ancestry, :faction, :alliance, :corporation)
      .find_by!(character_id: params[:id])
      .decorate
  end

  def destroy
    # character = current_user.characters.find_by!(character_id: params[:id])
    #
    # character.destroy!
    #
    # head :no_content
  end
end
