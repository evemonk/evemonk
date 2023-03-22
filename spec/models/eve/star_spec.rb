# frozen_string_literal: true

require "rails_helper"

describe Eve::Star do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("star_id") }

  it { expect(described_class.table_name).to eq("eve_stars") }

  it { should belong_to(:solar_system).class_name("Eve::System").optional(true) }

  it { should belong_to(:type).optional(true) }
end
