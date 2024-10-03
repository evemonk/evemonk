# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateAsteroidBeltJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:planet_id) { double }

    let(:asteroid_belt_id) { double }

    before do
      #
      # Eve::AsteroidBeltImporter.new(planet_id, asteroid_belt_id).import
      #
      expect(Eve::AsteroidBeltImporter).to receive(:new).with(planet_id, asteroid_belt_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(planet_id, asteroid_belt_id) }.not_to raise_error }
  end
end
