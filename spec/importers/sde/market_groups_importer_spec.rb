# frozen_string_literal: true

require "rails_helper"

describe Sde::MarketGroupsImporter do
  let(:file) { double }

  subject { described_class.new(file) }

  describe "#initialize" do
    its(:file) { should eq(file) }
  end

  describe "#import" do
    let(:content) { double }

    before { expect(File).to receive(:read).with(file).and_return(content) }

    let(:key) { double }

    let(:has_types) { double }

    let(:icon_id) { double }

    let(:entry) do
      {
        "hasTypes" => has_types,
        "iconID" => icon_id
      }
    end

    let(:entries) { {key => entry} }

    before { expect(YAML).to receive(:safe_load).with(content).and_return(entries) }

    let(:market_group) { instance_double(Eve::MarketGroup) }

    before { expect(Eve::MarketGroup).to receive(:find_or_initialize_by).with(market_group_id: key).and_return(market_group) }

    before do
      expect(market_group).to receive(:assign_attributes).with(has_types: has_types,
        icon_id: icon_id)
    end

    before { expect(market_group).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
