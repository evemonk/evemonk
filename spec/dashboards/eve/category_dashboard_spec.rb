# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CategoryDashboard do
  it { is_expected.to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:category) { build(:eve_category, name_en: "Implant") }

    specify { expect(subject.display_resource(category)).to eq("Implant") }
  end
end
