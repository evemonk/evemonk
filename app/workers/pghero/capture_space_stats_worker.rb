# frozen_string_literal: true

module Pghero
  class CaptureSpaceStatsWorker
    include Sidekiq::Worker

    def perform
      PgHero.capture_space_stats
    end
  end
end
