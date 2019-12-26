# frozen_string_literal: true

require "rails_helper"

describe Eve::TypeDogmaAttribute do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class.table_name).to eq("eve_type_dogma_attributes") }

  it { should belong_to(:type).with_primary_key("type_id").with_foreign_key("type_id").optional(true) }

  it { should belong_to(:dogma_attribute).with_primary_key("attribute_id").with_foreign_key("attribute_id").optional(true) }
end
