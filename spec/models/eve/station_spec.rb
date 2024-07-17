# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Station do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("station_id") }

  it { expect(described_class.table_name).to eq("eve_stations") }

  it { is_expected.to belong_to(:race).optional }

  it { is_expected.to belong_to(:type).optional }

  it { is_expected.to belong_to(:system).optional }

  it { is_expected.to have_one(:position).dependent(:destroy) }
end
