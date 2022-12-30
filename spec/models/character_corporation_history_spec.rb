# frozen_string_literal: true

require "rails_helper"

describe CharacterCorporationHistory do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:character).with_primary_key("character_id") }

  it { should belong_to(:corporation).class_name("Eve::Corporation").optional(true) }
end
