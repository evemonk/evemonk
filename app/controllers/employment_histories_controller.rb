# frozen_string_literal: true

class EmploymentHistoriesController < ApplicationController
  def index
    @character = policy_scope(Character)
      .find_by!(character_id: params[:character_id])
      .decorate
  end
end
