# frozen_string_literal: true

require "rails_helper"

describe Eve::Contract do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_characters") }

  it { should belong_to(:region).with_primary_key("region_id").optional(true) }
end
