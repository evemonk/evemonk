# frozen_string_literal: true

class MailsController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:race, :bloodline, :ancestry, :faction, :alliance, :corporation)
      .find_by!(character_id: params[:character_id])
      .decorate
  end
end
