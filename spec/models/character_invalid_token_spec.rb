# frozen_string_literal: true

require "spec_helper"

RSpec.describe CharacterInvalidToken, type: :model do
  specify { expect(subject).to be_a(RuntimeError) }
end
