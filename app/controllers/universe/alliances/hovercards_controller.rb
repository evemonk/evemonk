# frozen_string_literal: true

module Universe
  module Alliances
    class HovercardsController < ApplicationController
      skip_before_action :authenticate_user!

      def show
        @alliance = Eve::Alliance.find_by!(alliance_id: params[:alliance_id])

        render layout: false
      end
    end
  end
end
