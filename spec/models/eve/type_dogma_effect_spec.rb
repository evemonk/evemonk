# frozen_string_literal: true

require "rails_helper"

describe Eve::TypeDogmaEffect do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class.table_name).to eq("eve_type_dogma_effects") }

  it { should belong_to(:type).optional(true) }
end
