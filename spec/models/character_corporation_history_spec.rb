# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterCorporationHistory do
  it { is_expected.to be_an(ApplicationRecord) }

  it { is_expected.to belong_to(:character).with_primary_key("character_id") }

  it { is_expected.to belong_to(:corporation).class_name("Eve::Corporation").optional(true) }
end
