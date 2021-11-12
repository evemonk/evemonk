# frozen_string_literal: true

class BlueprintCalculatorController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    # @blueprints = Eve::Blueprint.search_by_name(params[:query]).limit(10)
    # @blueprints = Eve::Blueprint.published_blueprints.search_by_name(params[:query]).limit(10)
    @blueprints = Eve::Blueprint.unscoped.search_by_name(params[:query]).limit(10)
  end
end
