# frozen_string_literal: true

class EmploymentHistoriesController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(character_corporation_histories: :corporation)
      .find_by!(character_id: params[:character_id])
      .decorate
  end
end
