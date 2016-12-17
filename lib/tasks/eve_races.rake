namespace :eve do
  desc 'Import EveOnline SDE races'
  task races: :environment do
    ActiveRecord::Base.transaction do
      Eve::Race.destroy_all

      file = 'EVE/chrRaces.yaml'

      RacesImporter.new(file).execute
    end
  end
end
