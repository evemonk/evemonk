# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CharacterCorporationHistory do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_character_corporation_histories") }

  it { is_expected.to belong_to(:character) }

  it { is_expected.to belong_to(:corporation).optional(true) }
end
