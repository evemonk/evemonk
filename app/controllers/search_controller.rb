# frozen_string_literal: true

class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @alliances = Eve::SearchAlliancesQuery.new(params[:q], policy_scope(Eve::Alliance.all))
      .query
      .page(1)

    @corporations = Eve::SearchCorporationsQuery.new(params[:q], policy_scope(Eve::Corporation.all))
      .query
      .page(1)

    # @characters = policy_scope(Eve::SearchCharactersQuery.new(params[:q]).query).select(:id, :name).page(1)

    @characters = Eve::Character.search(params[:q]).page(1)

    if turbo_frame_request?
      render partial: "search",
        locals: {
          alliances: @alliances,
          corporations: @corporations,
          characters: @characters
        }
    else
      render :index
    end
  end
end
