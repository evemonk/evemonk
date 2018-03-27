# frozen_string_literal: true

namespace :eve do
  desc 'Import EveOnline Races'
  task races: :environment do
    RacesImporter.new.import
  end

  desc 'Import EveOnline Bloodlines'
  task bloodlines: :environment do
    BloodlinesImporter.new.import
  end

  desc 'Import EveOnline Factions'
  task factions: :environment do
    FactionsImporter.new.import
  end

  desc 'Import EveOnline Ancestries'
  task ancestries: :environment do
    AncestriesImporter.new.import
  end

  desc 'Import EveOnline Alliances'
  task alliances: :environment do
    AlliancesImporter.new.import
  end
end
