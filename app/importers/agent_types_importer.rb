class AgentTypesImporter
  attr_reader :agt_agent_types

  def initialize(file)
    @agt_agent_types = EveOnline::SDE::AgtAgentTypes.new(file)
  end

  def execute
    agt_agent_types.agt_agent_types.each do |agt_agent_type|
      Eve::AgentType.create!(agt_agent_type.as_json)
    end
  end
end
