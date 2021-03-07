# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationRecord, type: :model do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_corporations") }
end
