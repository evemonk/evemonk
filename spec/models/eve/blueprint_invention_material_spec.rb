# frozen_string_literal: true

require "rails_helper"

describe Eve::BlueprintInventionMaterial do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:blueprint).class_name("Eve::Blueprint").with_primary_key("type_id") }
end
