# frozen_string_literal: true

require_relative "config/environment"

scheduler = Rufus::Scheduler.new

# scheduler.in "3s" do
#  puts "#{Time.now}: Hello... Rufus"
#  # puts "Update characters"
#  # UpdateCharactersJob.perform_later
# end

# scheduler.every "1m" do
#   puts "#{Time.now}: Hello... Rufus11"
# end

# scheduler.every "10m" do
#  Rails.logger.info "Update characters"
#  Rails.logger.flush
#  puts "Update characters"
#  UpdateCharactersJob.perform_later
# end

scheduler.every "1h" do
  Rails.logger.info "Update characters"
  UpdateCharactersJob.perform_later
end

scheduler.join
