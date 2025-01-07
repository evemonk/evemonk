# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterSkill, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to belong_to(:character) }

  it { expect(subject).to belong_to(:skill).class_name("Eve::Type").optional(true) }
end
