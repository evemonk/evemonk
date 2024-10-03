# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::SystemDashboard do
  it { is_expected.to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:system) { build(:eve_system, name_en: "Penirgman") }

    specify { expect(subject.display_resource(system)).to eq("Penirgman") }
  end
end
