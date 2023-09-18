# frozen_string_literal: true

module Blueprints
  class SearchController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @blueprints = Eve::SearchBlueprintsQuery.new(params[:q]).query.limit(10)

      render layout: false
    end
  end
end
