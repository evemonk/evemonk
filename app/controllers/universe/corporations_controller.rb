# frozen_string_literal: true

module Universe
  class CorporationsController < ApplicationController
    skip_before_action :require_login

    def index
      @corporations = ::Eve::CorporationsSearcher
        .new(params[:q])
        .search
        .page(params[:page])
        .decorate
    end

    def show
      @corporation = ::Eve::Corporation
        .find_by!(corporation_id: params[:id])
        .decorate

      @characters = ::Eve::Character
        .where(corporation: @corporation)
        .order(:name)
        .decorate
    end
  end
end
