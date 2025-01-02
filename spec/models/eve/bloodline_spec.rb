# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Bloodline do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_bloodlines") }

  it { expect(subject).to belong_to(:corporation).optional(true) }

  it { expect(subject).to belong_to(:race).optional(true) }

  it { expect(subject).to belong_to(:ship).with_foreign_key(:ship_type_id).class_name("Eve::Ship").optional(true) }

  it { expect(subject).to have_many(:ancestries) }
end
