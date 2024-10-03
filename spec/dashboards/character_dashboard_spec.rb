# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterDashboard do
  it { expect(subject).to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:character) { build(:character, name: "Johnn Dillinger") }

    specify { expect(subject.display_resource(character)).to eq("Johnn Dillinger") }
  end
end
