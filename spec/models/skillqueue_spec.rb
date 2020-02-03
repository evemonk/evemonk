# frozen_string_literal: true

require "rails_helper"

describe Skillqueue do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:character) }

  it { should belong_to(:skill).class_name("Eve::Type").with_primary_key("type_id").with_foreign_key("skill_id").optional(true) }
end
