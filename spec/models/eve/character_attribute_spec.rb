# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterAttribute do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_character_attributes") }

  it { should belong_to(:icon).class_name("Eve::Icon").with_primary_key("icon_id").optional(true) }
end
