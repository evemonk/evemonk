# frozen_string_literal: true

return if defined?(Rails::Console) || Rails.env.test? || File.split($0).last == "rake"

s = Rufus::Scheduler.singleton

s.every "1h" do
  Rails.logger.info "Update characters"
  Rails.logger.flush
  UpdateCharactersJob.perform_later
end
