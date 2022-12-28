# frozen_string_literal: true

require "rails_helper"

describe Sde::AgentNamesImporter do
  let(:file) { double }

  subject { described_class.new(file) }

  describe "#initialize" do
    its(:file) { should eq(file) }
  end

  describe "#import" do
    let!(:eve_agent) { create(:eve_agent, id: 3_008_416, name: nil) }

    let(:content) { double }

    before { expect(File).to receive(:read).with(file).and_return(content) }

    let(:entry) do
      {
        "itemID" => 3_008_416,
        "itemName" => "Antaken Kamola"
      }
    end

    let(:entries) { [entry] }

    before { expect(YAML).to receive(:safe_load).with(content).and_return(entries) }

    before { expect(Eve::Agent).to receive(:find_each).and_yield(eve_agent) }

    before { expect(eve_agent).to receive(:update!).with({name: "Antaken Kamola"}) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
