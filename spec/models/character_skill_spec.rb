# frozen_string_literal: true

require "rails_helper"

describe CharacterSkill do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:character) }
end
