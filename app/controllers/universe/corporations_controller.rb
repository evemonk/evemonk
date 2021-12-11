# frozen_string_literal: true

module Universe
  class CorporationsController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      collection = Eve::SearchCorporationsQuery
        .new(params[:q])
        .query

      @pagy, @corporations = pagy(collection)
    end

    def show
      @corporation = ::Eve::Corporation
        .find_by!(corporation_id: params[:id])

      @characters = ::Eve::Character
        .where(corporation: @corporation)
        .order(:name)
    end
  end
end
