# frozen_string_literal: true

module Blueprints
  class CalculatorController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @blueprints = Eve::SearchBlueprintsQuery.new(params[:q]).query.limit(10)
    end

    def show
      @blueprint = Eve::Blueprint.published.find_by!(type_id: params[:id])
    end
  end
end
