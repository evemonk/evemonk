# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::PlanetDashboard do
  it { expect(subject).to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:planet) { build(:eve_planet, name: "Tanoo I") }

    specify { expect(subject.display_resource(planet)).to eq("Tanoo I") }
  end
end
