# frozen_string_literal: true

module Universe
  class SearchController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      # @alliances = Eve::AlliancesSearcher.new(params[:q]).search
      # @corporations = Eve::CorporationsSearcher.new(params[:q]).search
    end
  end
end
