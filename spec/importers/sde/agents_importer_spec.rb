# frozen_string_literal: true

require "rails_helper"

describe Sde::AgentsImporter do
  let(:file) { double }

  subject { described_class.new(file) }

  describe "#initialize" do
    its(:file) { should eq(file) }
  end

  describe "#import" do
    let(:content) { double }

    before { expect(File).to receive(:read).with(file).and_return(content) }

    let(:key) { double }

    let(:agent_type_id) { double }

    let(:corporation_id) { double }

    let(:division_id) { double }

    let(:is_locator) { double }

    let(:level) { double }

    let(:location_id) { double }

    let(:quality) { double }

    let(:entry) do
      {
        "agentTypeID" => agent_type_id,
        "corporationID" => corporation_id,
        "divisionID" => division_id,
        "isLocator" => is_locator,
        "level" => level,
        "locationID" => location_id,
        "quality" => quality
      }
    end

    let(:entries) { {key => entry} }

    before { expect(YAML).to receive(:safe_load).with(content).and_return(entries) }

    let(:eve_agent) { instance_double(Eve::Agent) }

    before { expect(Eve::Agent).to receive(:find_or_initialize_by).with(id: key).and_return(eve_agent) }

    before do
      expect(eve_agent).to receive(:assign_attributes).with(agent_type_id: agent_type_id,
        corporation_id: corporation_id,
        division_id: division_id,
        is_locator: is_locator,
        level: level,
        location_id: location_id,
        quality: quality)
    end

    before { expect(eve_agent).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
