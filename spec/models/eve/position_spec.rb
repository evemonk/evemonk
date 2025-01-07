# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Position, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to belong_to(:positionable) }
end
