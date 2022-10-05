# frozen_string_literal: true

namespace :migrate do
  desc "Migrate Eve::Unit#unit_id to #id"
  task units: :environment do
    Eve::Unit.find_each do |unit|
      unit.update!(id: unit.unit_id)
    end
  end
end
