# frozen_string_literal: true

class SearchablesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @alliances = Eve::SearchAlliancesQuery
      .new(params[:q])
      .query
      .page(params[:page])
  end
end
