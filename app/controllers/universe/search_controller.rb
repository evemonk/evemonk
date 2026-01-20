# frozen_string_literal: true

module Universe
  class SearchController < ApplicationController
    allow_unauthenticated_access

    def index
      # @alliances = Eve::AlliancesSearcher.new(params[:q]).search
      # @corporations = Eve::CorporationsSearcher.new(params[:q]).search
    end
  end
end
