# frozen_string_literal: true

class CharactersController < ApplicationController
  include Pundit::Authorization

  def index
    @characters = policy_scope(Character)
      .includes(:alliance, :corporation)
      .order(created_at: :asc)
      .page(params[:page])
  end

  def show
    @character = Character
      .includes(:race, :bloodline, :faction, :alliance, :corporation, :current_ship_type)
      .find_by!(character_id: params[:id])

    authorize @character
  end

  def update
    @character = Character.find_by!(character_id: params[:id])

    authorize @character

    UpdateCharacterInfoService.new(@character.character_id).execute

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = t(".successful", name: @character.name) }
      format.html { redirect_to character_path(@character.character_id) }
    end
  end

  def destroy
    @character = Character.find_by!(character_id: params[:id])

    authorize @character

    @character.destroy!

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = t(".successful", name: @character.name) }
      format.html { redirect_to characters_path, status: :see_other, notice: t(".successful", name: @character.name) }
    end
  end
end
