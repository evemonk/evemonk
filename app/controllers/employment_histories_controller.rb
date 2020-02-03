# frozen_string_literal: true

class EmploymentHistoriesController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation, character_corporation_histories: :corporation)
      .find_by!(character_id: params[:character_id])
      .decorate
  end
end
