# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::StarDashboard do
  it { expect(subject).to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:star) { build(:eve_star, name: "Tanoo - Star") }

    specify { expect(subject.display_resource(star)).to eq("Tanoo - Star") }
  end
end
