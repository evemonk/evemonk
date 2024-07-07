# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdatePlanetJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:planet_id) { double }

    before do
      #
      # Eve::PlanetImporter.new(planet_id).import
      #
      expect(Eve::PlanetImporter).to receive(:new).with(planet_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(planet_id) }.not_to raise_error }
  end
end
