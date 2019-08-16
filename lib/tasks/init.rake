# frozen_string_literal: true

namespace :evemonk do
  task init: :environment do
    Eve::RacesImporter.new.import

    Eve::FactionsImporter.new.import

    Eve::BloodlinesImporter.new.import

    Eve::AncestriesImporter.new.import
  end
end
