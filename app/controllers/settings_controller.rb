# frozen_string_literal: true

class SettingsController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation, :character_scopes)
      .find_by!(character_id: params[:character_id])
  end
end
