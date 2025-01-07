# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterOrder, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to be_a(Locationable) }

  it { expect(subject).to belong_to(:character) }

  it { expect(subject).to belong_to(:type).class_name("Eve::Type").optional(true) }

  it { expect(subject).to belong_to(:region).class_name("Eve::Region").optional(true) }
end
