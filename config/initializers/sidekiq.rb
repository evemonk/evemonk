# frozen_string_literal: true

if defined?(Sidekiq)
  Sidekiq.configure_server do |_|
    Yabeda::Prometheus::Exporter.start_metrics_server!
  end
end
