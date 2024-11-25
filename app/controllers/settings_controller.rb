# frozen_string_literal: true

class SettingsController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(:alliance, :corporation, :character_scopes)
      .find_by!(character_id: params[:character_id])
  end
end
