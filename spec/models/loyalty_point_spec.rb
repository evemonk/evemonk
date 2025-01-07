# frozen_string_literal: true

require "rails_helper"

RSpec.describe LoyaltyPoint, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to belong_to(:character) }

  it { expect(subject).to belong_to(:corporation).class_name("Eve::Corporation").optional }
end
