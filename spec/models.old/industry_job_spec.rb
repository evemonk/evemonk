# frozen_string_literal: true

require "rails_helper"

describe IndustryJob do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:character) }

  it { should belong_to(:product_type).class_name("Eve::Type").with_primary_key("type_id").with_foreign_key("product_type_id").optional(true) }

  it { should belong_to(:blueprint_type).class_name("Eve::Type").with_primary_key("type_id").with_foreign_key("blueprint_type_id").optional(true) }
end
