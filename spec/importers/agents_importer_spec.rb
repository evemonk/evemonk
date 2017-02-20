require 'rails_helper'

describe AgentsImporter do # rubocop:disable Metrics/BlockLength
  describe '#initialize' do
    let(:file) { double }

    let(:agt_agents) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::AgtAgents.new(file) => agt_agents
      #
      expect(EveOnline::SDE::AgtAgents).to receive(:new).with(file).and_return(agt_agents)
    end

    specify { expect(subject.agt_agents).to eq(agt_agents) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:agt_agent) { double }

    let(:json) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.agt_agents.agt_agents => [agt_agent]
      #
      expect(subject).to receive(:agt_agents) do
        double.tap do |a|
          expect(a).to receive(:agt_agents).and_return([agt_agent])
        end
      end
    end

    before { expect(agt_agent).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Agent.create!(json)
      #
      expect(Eve::Agent).to receive(:create!).with(json)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
