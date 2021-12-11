# frozen_string_literal: true

class CharactersController < ApplicationController
  def index
    collection = current_user.characters
      .includes(:alliance, :corporation)
      .order(created_at: :asc)

    @pagy, @characters = pagy(collection)
  end

  def show
    @character = current_user.characters
      .includes(:race, :bloodline, :ancestry, :faction, :alliance, :corporation, :current_ship_type)
      .find_by!(character_id: params[:id])
  end

  def update
    @character = current_user.characters.find_by!(character_id: params[:id])

    UpdateCharacterInfoService.new(@character.character_id).execute

    head :ok
  end

  def destroy
    @character = current_user.characters.find_by!(character_id: params[:id])

    @character.destroy!
  end
end
