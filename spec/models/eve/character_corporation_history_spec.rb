# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CharacterCorporationHistory, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_character_corporation_histories") }

  it { expect(subject).to belong_to(:character) }

  it { expect(subject).to belong_to(:corporation).optional(true) }
end
