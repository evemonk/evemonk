# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::RaceDashboard do
  it { expect(subject).to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:race) { build(:eve_race, name: "Caldari") }

    specify { expect(subject.display_resource(race)).to eq("Caldari") }
  end
end
