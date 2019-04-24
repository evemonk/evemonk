# frozen_string_literal: true

class PgHeroWorker
  include Sidekiq::Worker

  def perform
    PgHero.capture_query_stats
  end
end
