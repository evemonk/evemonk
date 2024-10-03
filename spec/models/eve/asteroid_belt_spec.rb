# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::AsteroidBelt do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("asteroid_belt_id") }

  it { is_expected.to belong_to(:system).optional(true) }

  it { is_expected.to belong_to(:planet).optional(true) }

  it { is_expected.to have_one(:position).dependent(:destroy) }
end
