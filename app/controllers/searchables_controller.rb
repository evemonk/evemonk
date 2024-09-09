# frozen_string_literal: true

class SearchablesController < ApplicationController
  skip_before_action :authenticate_user!

  # before_action :set_page

  def index
    @alliances = Eve::SearchAlliancesQuery
      .new(params[:q])
      .query
      .page(1)
      # .page(params[:page])
  end

  private

  # def set_page
  #   set_page_and_extract_portion_from Eve::Alliance.search_by_name_and_ticker(params[:q]), per_page: 10
  # end
end
