# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterOrder do
  it { is_expected.to be_an(ApplicationRecord) }

  it { is_expected.to be_a(Locationable) }

  it { is_expected.to belong_to(:character) }

  it { is_expected.to belong_to(:type).class_name("Eve::Type").optional(true) }

  it { is_expected.to belong_to(:region).class_name("Eve::Region").optional(true) }
end
