# frozen_string_literal: true

RailsPerformance.setup do |config|
  config.redis = Redis.new(url: ENV.fetch("REDIS_PERFORMANCE_URL", "redis://localhost:6381/1"))
  config.duration = 24.hours
  config.enabled = true
  config.mount_at = "/rails/performance"
  config.verify_access_proc = proc { |controller| controller.current_user && controller.current_user.admin? }
  config.home_link = "/"
end
