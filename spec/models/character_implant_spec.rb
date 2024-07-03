# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterImplant do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:character) }

  it { should belong_to(:implant).class_name("Eve::Implant").with_foreign_key("type_id").optional(true) }
end
