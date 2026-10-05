# frozen_string_literal: true

class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @alliances = Eve::SearchAlliancesQuery.new(q: params[:q], limit: 25, scope: policy_scope(Eve::Alliance.all))
      .query

    @corporations = Eve::SearchCorporationsQuery.new(q: params[:q], limit: 25, scope: policy_scope(Eve::Corporation.all))
      .query

    @characters = Eve::SearchCharactersQuery.new(q: params[:q], limit: 25, scope: policy_scope(Eve::Character.all))
      .query

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
