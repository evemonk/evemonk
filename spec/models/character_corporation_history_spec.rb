# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterCorporationHistory do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to belong_to(:character).with_primary_key("character_id") }

  it { expect(subject).to belong_to(:corporation).class_name("Eve::Corporation").optional(true) }
end
