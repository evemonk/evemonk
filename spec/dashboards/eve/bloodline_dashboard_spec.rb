# frozen_string_literal: true

require "rails_helper"

describe Eve::BloodlineDashboard do
  it { should be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:bloodline) { build(:eve_bloodline, name_en: "Brutor") }

    specify { expect(subject.display_resource(bloodline)).to eq("Brutor") }
  end
end
