# frozen_string_literal: true

require "rails_helper"

describe CharacterAsset do
  it { should be_an(ApplicationRecord) }

  it { should be_a(Locationable) }

  it { should belong_to(:character) }

  it { should belong_to(:type).class_name("Eve::Type").optional(true) }
end
