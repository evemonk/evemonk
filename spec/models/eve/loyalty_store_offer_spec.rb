# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::LoyaltyStoreOffer do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_loyalty_store_offers") }

  it { expect(subject).to belong_to(:corporation).optional(true) }

  it { expect(subject).to belong_to(:type).optional(true) }

  it { expect(subject).to have_many(:required_items).with_foreign_key("eve_loyalty_store_offer_id").dependent(:destroy) }
end
