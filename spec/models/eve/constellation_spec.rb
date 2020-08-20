# frozen_string_literal: true

require "rails_helper"

describe Eve::Constellation do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.translated_attribute_names).to eq(["name"]) }

  it { expect(described_class.table_name).to eq("eve_constellations") }

  it { should belong_to(:region).with_primary_key("region_id").optional(true) }

  it { should have_many(:systems).with_primary_key("constellation_id") }

  it { should have_one(:position).dependent(:destroy) }
end
