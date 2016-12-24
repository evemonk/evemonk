namespace :eve do
  desc 'Import EveOnline SDE races'
  task races: :environment do
    ActiveRecord::Base.transaction do
      Eve::Race.destroy_all

      file = 'EVE/chrRaces.yaml'

      RacesImporter.new(file).execute
    end
  end

  desc 'Import EveOnline SDE flags'
  task flags: :environment do
    ActiveRecord::Base.transaction do
      Eve::Flag.destroy_all

      file = 'EVE/invFlags.yaml'

      FlagsImporter.new(file).execute
    end
  end

  desc 'Import EveOnline SDE items'
  task items: :environment do
    ActiveRecord::Base.transaction do
      Eve::Item.destroy_all

      file = 'EVE/invItems.yaml'

      ItemsImporter.new(file).execute
    end
  end

  desc 'Import EveOnline SDE names'
  task names: :environment do
    ActiveRecord::Base.transaction do
      Eve::Name.destroy_all

      file = 'EVE/invNames.yaml'

      NamesImporter.new(file).execute
    end
  end

  desc 'Import EveOnline SDE positions'
  task positions: :environment do
    ActiveRecord::Base.transaction do
      Eve::Position.destroy_all

      file = 'EVE/invPositions.yaml'

      PositionsImporter.new(file).execute
    end
  end

  desc 'Import EveOnline SDE Agent Types'
  task agent_types: :environment do
    ActiveRecord::Base.transaction do
      Eve::AgentType.destroy_all

      file = 'EVE/agtAgentTypes.yaml'

      AgentTypesImporter.new(file).execute
    end
  end
end
