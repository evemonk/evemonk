# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterAsset, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to be_a(Locationable) }

  it { expect(subject).to belong_to(:character) }

  it { expect(subject).to belong_to(:type).class_name("Eve::Type").optional(true) }
end
