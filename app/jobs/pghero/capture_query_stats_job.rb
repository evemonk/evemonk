# frozen_string_literal: true

module Pghero
  class CaptureQueryStatsJob < ActiveJob::Base
    queue_as :pghero

    def perform
      PgHero.capture_query_stats
    end
  end
end
