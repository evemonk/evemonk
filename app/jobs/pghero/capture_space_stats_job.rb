# frozen_string_literal: true

module Pghero
  class CaptureSpaceStatsJob < ApplicationJob
    queue_as :pghero

    def perform
      if Rails.configuration.evemonk.pghero
        PgHero.capture_space_stats
      end
    end
  end
end
