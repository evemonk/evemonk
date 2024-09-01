# frozen_string_literal: true

require "rails_helper"

RSpec.describe LoyaltyPoint do
  it { is_expected.to be_an(ApplicationRecord) }

  it { is_expected.to belong_to(:character) }

  it { is_expected.to belong_to(:corporation).class_name("Eve::Corporation").optional }
end
