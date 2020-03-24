# frozen_string_literal: true

module Universe
  class SearchesController < ApplicationController
    def index
      # @alliances = Eve::AlliancesSearcher.new(params[:q]).search
      # @corporations = Eve::CorporationsSearcher.new(params[:q]).search
    end
  end
end
