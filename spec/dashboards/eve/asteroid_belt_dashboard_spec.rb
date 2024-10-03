# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::AsteroidBeltDashboard do
  it { is_expected.to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:asteroid_belt) { build(:eve_asteroid_belt, name: "Tanoo I - Asteroid Belt 1") }

    specify { expect(subject.display_resource(asteroid_belt)).to eq("Tanoo I - Asteroid Belt 1") }
  end
end
