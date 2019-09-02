# frozen_string_literal: true

require "rails_helper"

describe Eve::Ancestry do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.translated_attribute_names).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_ancestries") }

  it { should belong_to(:bloodline).with_primary_key(:bloodline_id).optional }
end
