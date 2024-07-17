# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Star do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("star_id") }

  it { expect(described_class.table_name).to eq("eve_stars") }

  it { is_expected.to belong_to(:solar_system).class_name("Eve::System").optional }

  it { is_expected.to belong_to(:type).optional }
end
