# frozen_string_literal: true
class AgentsImporter
  attr_reader :agt_agents

  def initialize(file)
    @agt_agents = EveOnline::SDE::AgtAgents.new(file)
  end

  def execute
    agt_agents.agt_agents.each do |agt_agent|
      Eve::Agent.create!(agt_agent.as_json)
    end
  end
end
