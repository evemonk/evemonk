# frozen_string_literal: true

require "rails_helper"

describe CharacterBlueprint do
  it { should be_an(ApplicationRecord) }

  it { should be_a(Locationable) }

  it { should belong_to(:character) }

  it { should belong_to(:blueprint).class_name("Eve::Blueprint").with_primary_key("type_id").with_foreign_key("type_id").optional(true) }
end
