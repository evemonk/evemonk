# frozen_string_literal: true

class CharactersController < ApplicationController
  def index
    @characters = current_user.characters
      .includes(:alliance, :corporation)
      .order(created_at: :asc)
      .page(params[:page])
  end

  def show
    @character = current_user.characters
      .includes(:race, :bloodline, :ancestry, :faction, :alliance, :corporation, :current_ship_type)
      .find_by!(character_id: params[:id])
  end

  def update
    @character = current_user.characters.find_by!(character_id: params[:id])

    UpdateCharacterInfoService.new(@character.character_id).execute

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = t(".successful_html", name: @character.name) }
      format.html { redirect_to character_path(@character.character_id) }
    end
  end

  def destroy
    @character = current_user.characters.find_by!(character_id: params[:id])

    @character.destroy!

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = t(".successful") }
      format.html { redirect_to characters_path, status: :see_other, notice: t(".successful") }
    end
  end
end
