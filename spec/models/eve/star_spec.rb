# frozen_string_literal: true

require "rails_helper"

describe Eve::Star do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("star_id") }

  it { should respond_to(:versions) }

  it { expect(described_class.table_name).to eq("eve_stars") }

  it { should belong_to(:solar_system).class_name("Eve::System").with_primary_key("system_id").with_foreign_key("solar_system_id").optional(true) }

  it { should belong_to(:type).with_primary_key("type_id").with_foreign_key("type_id").optional(true) }
end
