# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::IconDashboard do
  it { is_expected.to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:icon) { build(:eve_icon, description: "Asteroid") }

    specify { expect(subject.display_resource(icon)).to eq("Asteroid") }
  end
end
