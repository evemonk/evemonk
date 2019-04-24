# frozen_string_literal: true

module Pghero
  class CaptureQueryStatsWorker
    include Sidekiq::Worker

    def perform
      PgHero.capture_query_stats
    end
  end
end
