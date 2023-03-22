# frozen_string_literal: true

require "rails_helper"

describe Eve::AsteroidBelt do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("asteroid_belt_id") }

  it { should belong_to(:system).optional(true) }

  it { should belong_to(:planet).optional(true) }

  it { should have_one(:position).dependent(:destroy) }
end
