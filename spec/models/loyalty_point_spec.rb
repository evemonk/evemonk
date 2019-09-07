# frozen_string_literal: true

require "rails_helper"

describe LoyaltyPoint do
  it { should belong_to(:character) }

  it { should belong_to(:corporation).class_name("Eve::Corporation").with_primary_key(:corporation_id).optional(true) }
end
