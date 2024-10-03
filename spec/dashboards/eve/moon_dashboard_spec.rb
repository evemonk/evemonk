# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::MoonDashboard do
  it { is_expected.to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:moon) { build(:eve_moon, name: "Duripant II - Moon 1") }

    specify { expect(subject.display_resource(moon)).to eq("Duripant II - Moon 1") }
  end
end
