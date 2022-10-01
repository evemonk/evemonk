# frozen_string_literal: true

require "rails_helper"

describe Eve::Groups do
  it { expect(described_class::CYBER_SCIENCE_ID).to eq(748) }
end
