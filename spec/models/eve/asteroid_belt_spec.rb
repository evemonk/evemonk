# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::AsteroidBelt, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("asteroid_belt_id") }

  it { expect(subject).to belong_to(:system).optional(true) }

  it { expect(subject).to belong_to(:planet).optional(true) }

  it { expect(subject).to have_one(:position).dependent(:destroy) }
end
