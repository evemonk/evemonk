# frozen_string_literal: true

require "rails_helper"

describe Eve::TypeDashboard do
  it { should be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:type) { build(:eve_type, name_en: "Raven") }

    specify { expect(subject.display_resource(type)).to eq("Raven") }
  end
end
