# frozen_string_literal: true

# return if defined?(Rails::Console) || Rails.env.test? || File.split($0).last == "rake"

# class RufusHostLock
#   def initialize(lock_name)
#     @lock_name = lock_name
#   end
#
#   def lock
#     @lock_name == `hostname -f`.strip
#   end
#
#   def unlock
#     true
#   end
# end
#
# scheduler = Rufus::Scheduler.singleton(scheduler_lock: RufusHostLock.new('coffee.example.com'))

# ====
# scheduler = Rufus::Scheduler.singleton
#
# scheduler.every "10m" do
#   Rails.logger.info "Update characters"
#   Rails.logger.flush
#   UpdateCharactersJob.perform_later
# end
