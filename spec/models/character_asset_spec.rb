# frozen_string_literal: true

require "rails_helper"

describe CharacterAsset do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:character) }

  it { should belong_to(:type).class_name("Eve::Type").with_primary_key(:type_id).with_foreign_key(:type_id).optional(true) }
end
