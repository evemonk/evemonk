# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Station, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("station_id") }

  it { expect(described_class.table_name).to eq("eve_stations") }

  it { expect(subject).to belong_to(:race).optional(true) }

  it { expect(subject).to belong_to(:type).optional(true) }

  it { expect(subject).to belong_to(:system).optional(true) }

  it { expect(subject).to have_one(:position).dependent(:destroy) }
end
