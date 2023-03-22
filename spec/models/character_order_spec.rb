# frozen_string_literal: true

require "rails_helper"

describe CharacterOrder do
  it { should be_an(ApplicationRecord) }

  it { should be_a(Locationable) }

  it { should belong_to(:character) }

  it { should belong_to(:type).class_name("Eve::Type").optional(true) }

  it { should belong_to(:region).class_name("Eve::Region").optional(true) }
end
