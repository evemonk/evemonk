# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CorporationAllianceHistory do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_corporation_alliance_histories") }

  it { expect(subject).to belong_to(:corporation).optional(true) }

  it { expect(subject).to belong_to(:alliance).optional(true) }
end
