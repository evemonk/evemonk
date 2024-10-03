# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::BloodlineDashboard do
  it { is_expected.to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:bloodline) { build(:eve_bloodline, name_en: "Brutor") }

    specify { expect(subject.display_resource(bloodline)).to eq("Brutor") }
  end
end
