# frozen_string_literal: true

namespace :evemonk do
  task init: :environment do
    Eve::UpdateRacesJob.new.perform
    Eve::UpdateFactionsJob.new.perform
    Eve::UpdateBloodlinesJob.new.perform
    Eve::UpdateAncestriesJob.new.perform

    Sde::CharacterAttributesImporter.new("static/sde/bsd/chrAttributes.yaml").import
    Sde::IconsImporter.new("static/sde/fsd/iconIDs.yaml").import
  end
end
