# frozen_string_literal: true

class IndustryJobsController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])
      .decorate

    @industry_jobs = @character.industry_jobs
      .page(params[:page])
      .per(10)
  end
end
