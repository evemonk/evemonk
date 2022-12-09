# frozen_string_literal: true

module Universe
  class CorporationsController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @corporations = Eve::SearchCorporationsQuery
        .new(params[:q])
        .query
        .page(params[:page])
    end

    def show
      @corporation = ::Eve::Corporation
        .find_by!(corporation_id: params[:id])
    end
  end
end
