# frozen_string_literal: true

require "rails_helper"

describe Eve::LoyaltyStoreOffer do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_loyalty_store_offers") }

  it { should belong_to(:corporation).with_primary_key("corporation_id").optional(true) }

  it { should belong_to(:type).with_primary_key("type_id").optional(true) }
end
