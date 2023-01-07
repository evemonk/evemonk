# frozen_string_literal: true

require "rails_helper"

describe Eve::NpcCorporationDivision do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description_full", "leader_type_name"]) }
end
