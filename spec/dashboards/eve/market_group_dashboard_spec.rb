# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::MarketGroupDashboard do
  it { expect(subject).to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:market_group) { build(:eve_market_group, name_en: "Missiles") }

    specify { expect(subject.display_resource(market_group)).to eq("Missiles") }
  end
end
