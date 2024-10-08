# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::ConstellationDashboard do
  it { expect(subject).to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:constellation) { build(:eve_constellation, name_en: "Parud") }

    specify { expect(subject.display_resource(constellation)).to eq("Parud") }
  end
end
