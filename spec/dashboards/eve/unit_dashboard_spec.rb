# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UnitDashboard do
  it { is_expected.to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:unit) { build(:eve_unit, description: "Meter") }

    specify { expect(subject.display_resource(unit)).to eq("Meter") }
  end
end
