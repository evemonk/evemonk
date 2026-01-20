# frozen_string_literal: true

module Corporations
  class TopController < ApplicationController
    allow_unauthenticated_access

    def index
      corporations = policy_scope(Eve::Corporation).not_npc.order(member_count: :desc).limit(20)

      render TopCorporationsComponent.new(corporations: corporations, lazy: false), layout: false
    end
  end
end
