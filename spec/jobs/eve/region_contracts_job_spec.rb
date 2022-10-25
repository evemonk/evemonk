# frozen_string_literal: true

require "rails_helper"

describe Eve::RegionContractsJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:id) { double }

    let(:page) { double }

    before do
      #
      # Eve::RegionContractsImporter.new(id, page).import
      #
      expect(Eve::RegionContractsImporter).to receive(:new).with(id, page) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(id, page) }.not_to raise_error }
  end
end
