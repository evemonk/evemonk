# frozen_string_literal: true

require "rails_helper"

describe Eve::StargateDashboard do
  it { should be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:stargate) { build(:eve_stargate, name: "Stargate (Akpivem)") }

    specify { expect(subject.display_resource(stargate)).to eq("Stargate (Akpivem)") }
  end
end
