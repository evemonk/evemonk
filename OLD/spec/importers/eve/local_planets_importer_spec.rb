# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::LocalPlanetsImporter do
  describe "#import" do
    let(:planet_id) { double }

    before do
      #
      # Eve::Planet.pluck(:planet_id) => [planet_id]
      #
      expect(Eve::Planet).to receive(:pluck).with(:planet_id).and_return([planet_id])
    end

    before { expect(Eve::UpdatePlanetJob).to receive(:perform_later).with(planet_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
