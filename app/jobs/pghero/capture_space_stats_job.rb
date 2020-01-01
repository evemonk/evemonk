# frozen_string_literal: true

module Pghero
  class CaptureSpaceStatsJob < ActiveJob::Base
    queue_as :pghero

    def perform
      PgHero.capture_space_stats
    end
  end
end
