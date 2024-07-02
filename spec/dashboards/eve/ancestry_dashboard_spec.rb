# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::AncestryDashboard do
  it { should be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:ancestry) { build(:eve_ancestry, name_en: "Liberated Children") }

    specify { expect(subject.display_resource(ancestry)).to eq("Liberated Children") }
  end
end
