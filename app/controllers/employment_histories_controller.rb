# frozen_string_literal: true

class EmploymentHistoriesController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    @character_corporation_histories = CharacterCorporationHistory.where(character_id: @character.character_id)
      .includes(:corporation)
      .order(start_date: :desc)
  end
end
