# frozen_string_literal: true

class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @alliances = policy_scope(Eve::SearchAlliancesQuery.new(params[:q]).query)
      .select(:id, :name, :corporations_count, :characters_count)
      .page(1)

    @corporations = policy_scope(Eve::SearchCorporationsQuery.new(params[:q]).query)
      .select(:id, :name, :member_count)
      .page(1)

    @characters = policy_scope(Eve::SearchCharactersQuery.new(params[:q]).query).select(:id, :name).page(1)

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
