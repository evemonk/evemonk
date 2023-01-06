# frozen_string_literal: true

module Corporations
  class TopController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @corporations = ::Eve::Corporation.not_npc.order(member_count: :desc).limit(20)

      render layout: false
    end
  end
end
