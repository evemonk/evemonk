# frozen_string_literal: true

require "rails_helper"

describe CharacterImplant do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:character) }

  it { should belong_to(:implant).class_name("Eve::Implant").with_primary_key("type_id").with_foreign_key("type_id").optional(true) }
end
