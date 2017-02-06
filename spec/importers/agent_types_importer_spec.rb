require 'rails_helper'

describe AgentTypesImporter do # rubocop:disable Metrics/BlockLength
  describe '#initialize' do
    let(:file) { double }

    let(:agt_agent_types) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::AgtAgentTypes.new(file) => agt_agent_types
      #
      expect(EveOnline::SDE::AgtAgentTypes).to receive(:new).with(file).and_return(agt_agent_types)
    end

    specify { expect(subject.agt_agent_types).to eq(agt_agent_types) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:agt_agent_type) { double }

    let(:json) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.agt_agent_types.agt_agent_types => [agt_agent_type]
      #
      expect(subject).to receive(:agt_agent_types) do
        double.tap do |a|
          expect(a).to receive(:agt_agent_types).and_return([agt_agent_type])
        end
      end
    end

    before { expect(agt_agent_type).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::AgentType.create!(json)
      #
      expect(Eve::AgentType).to receive(:create!).with(json)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
