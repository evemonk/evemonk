# frozen_string_literal: true

module Universe
  class CorporationsController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      # @corporations = Eve::SearchCorporationsQuery.new(params[:q]).query.page(params[:page])

      @corporations = policy_scope(Eve::Corporation).order(:name).page(params[:page])
    end

    def show
      @corporation = Eve::Corporation.find(params[:id])

      authorize @corporation
    end
  end
end
