# frozen_string_literal: true

module Universe
  class CorporationsController < ApplicationController
    skip_before_action :require_login

    def index
      @corporations = ::Eve::CorporationsSearcher
        .new(params[:q], policy_scope(::Eve::Corporation))
        .search
        .page(params[:page])
        .decorate
    end

    def show
      @corporation = policy_scope(::Eve::Corporation)
        .find_by!(corporation_id: params[:id])
        .decorate

      @characters = policy_scope(::Eve::Character)
        .where(corporation: @corporation)
        .order(:name)
        .decorate

      skip_authorization
    end
  end
end
