# frozen_string_literal: true

if defined?(Sidekiq)
  Sidekiq.configure_server do |config|
    config.redis = {url: ENV["REDIS_URL"]}

    Yabeda::Prometheus::Exporter.start_metrics_server!
  end

  Sidekiq.configure_client do |config|
    config.redis = {url: ENV["REDIS_URL"]}
  end
end
