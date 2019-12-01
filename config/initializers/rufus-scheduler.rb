# frozen_string_literal: true

return if defined?(Rails::Console) || Rails.env.test? || File.split($0).last == 'rake'

s = Rufus::Scheduler.singleton

s.every '1m' do
  Rails.logger.info "hello, it's #{Time.now}"
  Rails.logger.flush
end
