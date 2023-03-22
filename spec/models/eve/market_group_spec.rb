# frozen_string_literal: true

require "rails_helper"

describe Eve::MarketGroup do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("market_group_id") }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_market_groups") }

  it { should belong_to(:parent_group).class_name("Eve::MarketGroup").optional(true) }

  it { should belong_to(:icon).optional(true) }

  it { should have_many(:types) }

  it { should have_many(:subgroups).class_name("Eve::MarketGroup").with_foreign_key("parent_group_id") }

  describe ".main_groups" do
    let!(:eve_market_group_1) { create(:eve_market_group, parent_group_id: nil) }

    let!(:eve_market_group_2) { create(:eve_market_group, parent_group_id: 1) }

    specify { expect(described_class.main_groups.count).to eq(1) }

    specify { expect(described_class.main_groups).to eq([eve_market_group_1]) }
  end
end
