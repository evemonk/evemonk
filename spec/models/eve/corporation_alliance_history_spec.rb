# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CorporationAllianceHistory do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_corporation_alliance_histories") }

  it { is_expected.to belong_to(:corporation).optional(true) }

  it { is_expected.to belong_to(:alliance).optional(true) }
end
