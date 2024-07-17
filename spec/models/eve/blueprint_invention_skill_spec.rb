# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::BlueprintInventionSkill do
  it { is_expected.to be_an(ApplicationRecord) }

  it { is_expected.to belong_to(:blueprint) }

  it { is_expected.to belong_to(:type).optional }
end
