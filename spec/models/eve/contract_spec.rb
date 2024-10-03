# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Contract do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_contracts") }

  it { is_expected.to belong_to(:region).with_primary_key("region_id").optional(true) }

  it { is_expected.to belong_to(:issuer).class_name("Eve::Character").with_primary_key("character_id").optional(true) }

  it { is_expected.to belong_to(:issuer_corporation).class_name("Eve::Corporation").with_primary_key("corporation_id").optional(true) }
end
