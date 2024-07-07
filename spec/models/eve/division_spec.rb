# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Division do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description_full", "leader_type_name"]) }

  it { should have_many(:agents) }
end
