# frozen_string_literal: true

module Universe
  class CorporationsController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      skip_policy_scope

      @corporations = Eve::SearchCorporationsQuery
        .new(params[:q])
        .query
        .page(params[:page])
    end

    def show
      skip_authorization

      @corporation = ::Eve::Corporation.find(params[:id])
    end
  end
end
