# frozen_string_literal: true

module Pghero
  class CaptureQueryStatsJob < ApplicationJob
    queue_as :pghero

    def perform
      if Flipper.enabled?(:pghero)
        PgHero.capture_query_stats
      end
    end
  end
end
