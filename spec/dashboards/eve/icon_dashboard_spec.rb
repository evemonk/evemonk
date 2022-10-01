# frozen_string_literal: true

require "rails_helper"

describe Eve::IconDashboard do
  it { should be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:icon) { build(:eve_icon, description: "Asteroid") }

    specify { expect(subject.display_resource(icon)).to eq("Asteroid") }
  end
end
