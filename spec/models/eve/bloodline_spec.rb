# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Bloodline do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_bloodlines") }

  it { should belong_to(:corporation).optional(true) }

  it { should belong_to(:race).optional(true) }

  it { should belong_to(:ship_type).class_name("Eve::Ship").optional(true) }

  it { should have_many(:ancestries) }
end
