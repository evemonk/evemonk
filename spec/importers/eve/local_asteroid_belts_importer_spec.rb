# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalAsteroidBeltsImporter do
  describe "#import" do
    let(:planet_id) { double }

    let(:asteroid_belt_id) { double }

    before do
      #
      # Eve::AsteroidBelt.pluck(:planet_id, :id) => [[planet_id, asteroid_belt_id]]
      #
      expect(Eve::AsteroidBelt).to receive(:pluck).with(:planet_id, :id).and_return([[planet_id, asteroid_belt_id]])
    end

    before { expect(Eve::UpdateAsteroidBeltJob).to receive(:perform_later).with(planet_id, asteroid_belt_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
