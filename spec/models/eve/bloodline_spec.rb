# frozen_string_literal: true

require "rails_helper"

describe Eve::Bloodline do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.translated_attribute_names).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_bloodlines") }

  it { should belong_to(:corporation).with_primary_key("corporation_id").optional(true) }

  it { should belong_to(:race).with_primary_key("race_id").optional(true) }

  it { should belong_to(:ship_type).class_name("Eve::Ship").with_foreign_key("ship_type_id").with_primary_key("type_id").optional(true) }

  it { should have_many(:ancestries) }
end
