# frozen_string_literal: true

module Corporations
  class TopController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      corporations = policy_scope(Eve::Corporation).not_npc.order(member_count: :desc).limit(20)

      render TopCorporationsComponent.new(corporations: corporations, lazy: false), layout: false
    end
  end
end
