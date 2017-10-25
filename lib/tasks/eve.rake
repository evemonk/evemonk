# frozen_string_literal: true

namespace :eve do
  desc 'Import EveOnline SDE Agents'
  task agt_agents: :environment do
    ActiveRecord::Base.transaction do
      Eve::Agent.destroy_all

      file = 'EVE/sde/bsd/agtAgents.yaml'

      AgentsImporter.new(file).execute
    end
  end

  desc 'Import EveOnline SDE Agent Types'
  task agt_agent_types: :environment do
    ActiveRecord::Base.transaction do
      Eve::AgentType.destroy_all

      file = 'EVE/sde/bsd/agtAgentTypes.yaml'

      AgentTypesImporter.new(file).execute
    end
  end

  desc 'Import EveOnline SDE Research Agents'
  task research_agents: :environment do
    ActiveRecord::Base.transaction do
      Eve::ResearchAgent.destroy_all

      file = 'EVE/sde/bsd/agtResearchAgents.yaml'

      ResearchAgentsImporter.new(file).execute
    end
  end

  desc 'Import EveOnline SDE Ancestries'
  task ancestries: :environment do
    ActiveRecord::Base.transaction do
      # Eve::Ancestry.destroy_all

      # file = 'EVE/sde/bsd/chrAncestries.yaml'

      # AncestriesImporter.new(file).execute
    end
  end

  desc 'Import EveOnline SDE races'
  task races: :environment do
    ActiveRecord::Base.transaction do
      Eve::Race.destroy_all

      file = 'EVE/sde/bsd/chrRaces.yaml'

      RacesImporter.new(file).execute
    end
  end

  desc 'Import EveOnline SDE flags'
  task flags: :environment do
    ActiveRecord::Base.transaction do
      Eve::Flag.destroy_all

      file = 'EVE/sde/bsd/invFlags.yaml'

      FlagsImporter.new(file).execute
    end
  end

  desc 'Import EveOnline SDE items'
  task items: :environment do
    ActiveRecord::Base.transaction do
      Eve::Item.destroy_all

      file = 'EVE/sde/bsd/invItems.yaml'

      ItemsImporter.new(file).execute
    end
  end

  desc 'Import EveOnline SDE names'
  task names: :environment do
    ActiveRecord::Base.transaction do
      Eve::Name.destroy_all

      file = 'EVE/sde/bsd/invNames.yaml'

      NamesImporter.new(file).execute
    end
  end

  desc 'Import EveOnline SDE positions'
  task positions: :environment do
    ActiveRecord::Base.transaction do
      Eve::Position.destroy_all

      file = 'EVE/sde/bsd/invPositions.yaml'

      PositionsImporter.new(file).execute
    end
  end
end
