# frozen_string_literal: true

require "rails_helper"

describe Eve::Bloodline do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.translated_attribute_names).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_bloodlines") }

  it { should belong_to(:corporation).with_primary_key(:corporation_id).optional }

  it { should belong_to(:race).with_primary_key(:race_id).optional }
end
