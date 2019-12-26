# frozen_string_literal: true

require "rails_helper"

describe Eve::Group do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.translated_attribute_names).to eq(["name"]) }

  it { expect(described_class.table_name).to eq("eve_groups") }

  it { should belong_to(:category).with_primary_key("category_id").with_foreign_key("category_id").optional(true) }

  it { should have_many(:types).with_primary_key("group_id").with_foreign_key("group_id") }
end
