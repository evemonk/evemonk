# frozen_string_literal: true

class TrainingQueuesController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    @skillqueues = @character.skillqueues
      .includes(:skill)
      .order(:queue_position)
      .where("skillqueues.finish_date >= :now", now: Time.zone.now)
  end
end
