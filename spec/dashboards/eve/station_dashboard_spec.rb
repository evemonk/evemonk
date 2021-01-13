# frozen_string_literal: true

require "rails_helper"

describe Eve::StationDashboard do
  it { should be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:station) { build(:eve_station, name: "Penirgman V - Moon 3 - Ishukone Corporation Factory") }

    specify { expect(subject.display_resource(station)).to eq("Penirgman V - Moon 3 - Ishukone Corporation Factory") }
  end
end
