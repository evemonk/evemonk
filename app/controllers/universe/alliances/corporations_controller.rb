# frozen_string_literal: true

module Universe
  module Alliances
    class CorporationsController < ApplicationController
      skip_before_action :authenticate_user!

      def index
        @alliance = ::Eve::Alliance.find(params[:alliance_id])

        @corporations = ::Eve::Corporation
          .where(alliance: @alliance)
          .order(:name)

        render layout: false
      end
    end
  end
end
