# frozen_string_literal: true

module Universe
  class CorporationsController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @corporations = ::Eve::CorporationsSearcher
        .new(params[:q])
        .search
        .page(params[:page])
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
