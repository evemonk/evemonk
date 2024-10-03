# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::RequiredItem do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_required_items") }

  it { is_expected.to belong_to(:loyalty_store_offer).with_foreign_key("eve_loyalty_store_offer_id") }

  it { is_expected.to belong_to(:type).with_primary_key("type_id").optional(true) }
end
