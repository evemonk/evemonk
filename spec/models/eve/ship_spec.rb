# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Ship, type: :model do
  it { expect(subject).to be_a(Eve::Type) }
end
