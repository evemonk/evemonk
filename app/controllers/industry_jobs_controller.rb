# frozen_string_literal: true

class IndustryJobsController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    # @industry_jobs = @character.industry_jobs
    #   .includes(:blueprint_type)
    #   .page(params[:page])
    #   .per(10)
  end
end
