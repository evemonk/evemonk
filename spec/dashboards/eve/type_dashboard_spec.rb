# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::TypeDashboard do
  it { expect(subject).to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:type) { build(:eve_type, name_en: "Raven") }

    specify { expect(subject.display_resource(type)).to eq("Raven") }
  end
end
