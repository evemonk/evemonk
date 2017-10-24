# frozen_string_literal: true

class ResearchAgentsImporter
  attr_reader :agt_research_agents

  def initialize(file)
    @agt_research_agents = EveOnline::SDE::AgtResearchAgents.new(file)
  end

  def execute
    agt_research_agents.agt_research_agents.each do |agt_research_agent|
      Eve::ResearchAgent.create!(agt_research_agent.as_json)
    end
  end
end
