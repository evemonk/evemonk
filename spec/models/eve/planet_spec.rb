# frozen_string_literal: true

require "rails_helper"

describe Eve::Planet do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("planet_id") }

  it { should respond_to(:versions) }

  it { expect(described_class.table_name).to eq("eve_planets") }

  it { should belong_to(:system).with_primary_key("system_id").optional(true) }

  it { should belong_to(:type).with_primary_key("type_id").optional(true) }

  it { should have_many(:moons).with_primary_key("planet_id") }

  it { should have_many(:asteroid_belts).with_primary_key("planet_id") }

  it { should have_one(:position).dependent(:destroy) }
end
