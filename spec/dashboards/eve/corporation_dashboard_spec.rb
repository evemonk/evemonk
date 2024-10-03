# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CorporationDashboard do
  it { expect(subject).to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:corporation) { build(:eve_corporation, name: "Freighting Solutions Inc.") }

    specify { expect(subject.display_resource(corporation)).to eq("Freighting Solutions Inc.") }
  end
end
