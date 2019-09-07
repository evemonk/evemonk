# frozen_string_literal: true

require "rails_helper"

describe Eve::Race do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.translated_attribute_names).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_races") }

  it { should belong_to(:alliance).with_primary_key(:alliance_id).optional(true) }
end
