# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::TypeDogmaEffect do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_type_dogma_effects") }

  it { should belong_to(:type).optional(true) }
end
