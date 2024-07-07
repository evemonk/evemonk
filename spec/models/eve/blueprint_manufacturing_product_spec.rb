# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::BlueprintManufacturingProduct do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:blueprint) }

  it { should belong_to(:type).optional(true) }
end
