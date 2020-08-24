# frozen_string_literal: true

namespace :counters do
  task update: :environment do
    Eve::Alliance.find_each do |alliance|
      alliance.reset_corporations_count

      alliance.reset_characters_count
    end
  end
end
