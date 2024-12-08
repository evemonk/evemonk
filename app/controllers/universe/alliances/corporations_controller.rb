# frozen_string_literal: true

module Universe
  module Alliances
    class CorporationsController < ApplicationController
      skip_before_action :authenticate_user!

      def index
        @alliance = policy_scope(Eve::Alliance).find(params[:alliance_id])

        @corporations = policy_scope(Eve::Corporation)
          .where(alliance: @alliance)
          .order(:name)

        render layout: false
      end
    end
  end
end
