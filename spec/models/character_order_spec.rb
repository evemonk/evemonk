# frozen_string_literal: true

require "rails_helper"

describe CharacterOrder do
  it { should be_an(ApplicationRecord) }

  it { should be_a(Locationable) }

  it { should respond_to(:versions) }

  it { should belong_to(:character) }

  it { should belong_to(:type).class_name("Eve::Type").with_primary_key("type_id").with_foreign_key("type_id").optional(true) }

  it { should belong_to(:region).class_name("Eve::Region").with_primary_key("region_id").with_foreign_key("region_id").optional(true) }
end
