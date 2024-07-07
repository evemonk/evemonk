# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::AllianceDashboard do
  it { should be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:alliance) { build(:eve_alliance, name: "The Dead Parrots") }

    specify { expect(subject.display_resource(alliance)).to eq("The Dead Parrots") }
  end
end
