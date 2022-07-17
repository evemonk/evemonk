# frozen_string_literal: true

require "rails_helper"

describe Eve::Contract do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_contracts") }

  it { should belong_to(:region).optional(true) }

  it { should belong_to(:issuer).class_name("Eve::Character").with_primary_key("character_id").optional(true) }

  it { should belong_to(:issuer_corporation).class_name("Eve::Corporation").with_primary_key("corporation_id").optional(true) }
end
