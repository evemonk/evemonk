# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::BlueprintManufacturingProduct, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to belong_to(:blueprint) }

  it { expect(subject).to belong_to(:type).optional(true) }
end
