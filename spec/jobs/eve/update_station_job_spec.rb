# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateStationJob do
  it { is_expected.to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:station_id) { double }

    before do
      #
      # Eve::StationImporter.new(station_id).import
      #
      expect(Eve::StationImporter).to receive(:new).with(station_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(station_id) }.not_to raise_error }
  end
end
