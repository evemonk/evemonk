# frozen_string_literal: true

require "rails_helper"

describe Eve::BlueprintInventionSkill do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:blueprint).class_name("Eve::Blueprint").with_primary_key("type_id") }
end
