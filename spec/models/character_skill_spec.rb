# frozen_string_literal: true

require "rails_helper"

describe CharacterSkill do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:character) }

  it { should belong_to(:skill).class_name("Eve::Type").optional(true) }
end
