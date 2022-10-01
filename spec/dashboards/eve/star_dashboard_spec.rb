# frozen_string_literal: true

require "rails_helper"

describe Eve::StarDashboard do
  it { should be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:star) { build(:eve_star, name: "Tanoo - Star") }

    specify { expect(subject.display_resource(star)).to eq("Tanoo - Star") }
  end
end
