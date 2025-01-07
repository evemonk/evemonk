# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Division, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description_full", "leader_type_name"]) }

  it { expect(subject).to have_many(:agents) }
end
