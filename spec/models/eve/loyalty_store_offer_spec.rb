# frozen_string_literal: true

require "rails_helper"

describe Eve::LoyaltyStoreOffer do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_loyalty_store_offers") }

  it { should belong_to(:corporation).optional(true) }

  it { should belong_to(:type).optional(true) }

  it { should have_many(:required_items).with_foreign_key("eve_loyalty_store_offer_id").dependent(:destroy) }
end
