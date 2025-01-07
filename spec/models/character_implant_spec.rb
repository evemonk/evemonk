# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterImplant, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to belong_to(:character) }

  it { expect(subject).to belong_to(:implant).class_name("Eve::Implant").with_foreign_key("type_id").optional(true) }
end
