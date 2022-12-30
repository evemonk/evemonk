# frozen_string_literal: true

require "rails_helper"

describe LoyaltyPoint do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:character) }

  it { should belong_to(:corporation).class_name("Eve::Corporation").optional(true) }
end
