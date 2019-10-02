# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationAllianceHistory do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_corporation_alliance_histories") }

  it { should belong_to(:corporation).with_primary_key("corporation_id") }

  it { should belong_to(:alliance).with_primary_key("alliance_id").optional(true) }
end
