# frozen_string_literal: true

require "rails_helper"

describe Eve::Station do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("station_id") }

  it { expect(described_class.table_name).to eq("eve_stations") }

  it { should belong_to(:race).optional(true) }

  it { should belong_to(:type).optional(true) }

  it { should belong_to(:system).optional(true) }

  it { should have_one(:position).dependent(:destroy) }
end
