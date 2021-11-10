# frozen_string_literal: true

module Blueprints
  class SearchController < ApplicationController
    skip_before_action :authenticate_user!

    def create
      @blueprints = if params[:q].present?
                      Eve::Blueprint.unscoped.search_by_name(params[:q]).limit(10)
                    else
                      Eve::Blueprint.unscoped.search_by_name("blueprint").limit(10)
                    end
    end
  end
end
