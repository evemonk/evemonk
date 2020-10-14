# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterAttribute do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.translated_attribute_names).to eq(["name"]) }

  it { expect(described_class.table_name).to eq("eve_character_attributes") }

  it { should belong_to(:icon).class_name("Eve::Icon").with_primary_key("icon_id").optional(true) }
end
