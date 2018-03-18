# frozen_string_literal: true

namespace :eve do
  desc 'Import EveOnline Races'
  task races: :environment do
    ActiveRecord::Base.transaction do
      Eve::Race.destroy_all

      RacesImporter.new.import
    end
  end

  desc 'Import EveOnline Bloodlines'
  task bloodlines: :environment do
    ActiveRecord::Base.transaction do
      Eve::Bloodline.destroy_all

      BloodlinesImporter.new.import
    end
  end
end
