# frozen_string_literal: true

require "rails_helper"

describe Eve::MarketGroup do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_market_groups") }

  it { should belong_to(:parent_group).class_name("Eve::MarketGroup").with_primary_key("market_group_id").with_foreign_key("parent_group_id").optional(true) }

  it { should have_many(:types).with_primary_key("market_group_id").with_foreign_key("market_group_id") }
end
