# frozen_string_literal: true

if defined?(Sidekiq)
  require "sidekiq-scheduler"

  Sidekiq.configure_server do |config|
    config.redis = {url: ENV["REDIS_URL"]}

    Yabeda::Prometheus::Exporter.start_metrics_server!

    config.on(:startup) do
      SidekiqScheduler::Scheduler.load_schedule!
    end
  end

  Sidekiq.configure_client do |config|
    config.redis = {url: ENV["REDIS_URL"]}
  end
end
