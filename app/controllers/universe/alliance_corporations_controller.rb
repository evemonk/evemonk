# frozen_string_literal: true

module Universe
  class AllianceCorporationsController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @alliance = ::Eve::Alliance
        .find_by!(alliance_id: params[:alliance_id])
        .decorate

      @corporations = ::Eve::Corporation
        .where(alliance: @alliance)
        .order(:name)
        .decorate
    end
  end
end
