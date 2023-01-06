# frozen_string_literal: true

module Alliances
  class TopController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @alliances = ::Eve::Alliance.order(characters_count: :desc).limit(20)

      render layout: false
    end
  end
end
