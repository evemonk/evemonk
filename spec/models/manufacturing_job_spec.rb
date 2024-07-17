# frozen_string_literal: true

require "rails_helper"

RSpec.describe ManufacturingJob do
  it { is_expected.to be_an(ApplicationRecord) }

  it { is_expected.to belong_to(:character) }
end
