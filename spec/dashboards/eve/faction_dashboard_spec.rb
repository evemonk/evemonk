# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::FactionDashboard do
  it { is_expected.to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:faction) { build(:eve_faction, name_en: "Caldari State") }

    specify { expect(subject.display_resource(faction)).to eq("Caldari State") }
  end
end
