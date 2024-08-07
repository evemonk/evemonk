# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CorporationAllianceHistory do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_corporation_alliance_histories") }

  it { should belong_to(:corporation).optional(true) }

  it { should belong_to(:alliance).optional(true) }
end
