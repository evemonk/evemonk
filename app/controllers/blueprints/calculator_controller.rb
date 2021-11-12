# frozen_string_literal: true

module Blueprints
  class CalculatorController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @blueprints = if params[:q].present?
                      Eve::Blueprint.published.search_by_name(params[:q]).limit(10)
                    else
                      Eve::Blueprint.published.limit(10)
                    end
    end
  end
end
