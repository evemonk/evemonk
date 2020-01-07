# frozen_string_literal: true

require "rails_helper"

describe Eve::Star do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class.table_name).to eq("eve_stars") }

  it { should belong_to(:type).with_primary_key("type_id").with_foreign_key("type_id").optional(true) }
end
