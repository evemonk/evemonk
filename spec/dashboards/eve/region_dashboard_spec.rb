# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::RegionDashboard do
  it { is_expected.to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:region) { build(:eve_region, name_en: "Domain") }

    specify { expect(subject.display_resource(region)).to eq("Domain") }
  end
end
