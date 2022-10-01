# frozen_string_literal: true

require "rails_helper"

describe Eve::Categories do
  it { expect(described_class::SKILLS_ID).to eq(16) }
end
