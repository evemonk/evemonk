require 'rails_helper'

describe ResearchAgentsImporter do # rubocop:disable Metrics/BlockLength
  describe '#initialize' do
    let(:file) { double }

    let(:agt_research_agents) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::AgtResearchAgents.new(file) => agt_research_agents
      #
      expect(EveOnline::SDE::AgtResearchAgents).to receive(:new).with(file).and_return(agt_research_agents)
    end

    specify { expect(subject.agt_research_agents).to eq(agt_research_agents) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:agt_research_agent) { double }

    let(:json) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.agt_research_agents.agt_research_agents => [agt_research_agent]
      #
      expect(subject).to receive(:agt_research_agents) do
        double.tap do |a|
          expect(a).to receive(:agt_research_agents).and_return([agt_research_agent])
        end
      end
    end

    before { expect(agt_research_agent).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::ResearchAgent.create!(json)
      #
      expect(Eve::ResearchAgent).to receive(:create!).with(json)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
