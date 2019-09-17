# frozen_string_literal: true

namespace :counters do
  task update: :environment do
    Eve::Alliance.find_each do |alliance|
      Eve::Alliance.reset_counters(alliance.id, :alliance_corporations)

      alliance.reset_characters_count
    end
  end
end
