# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterCorporationHistory do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_character_corporation_histories") }

  it { should belong_to(:character) }

  it { should belong_to(:corporation).optional(true) }
end
