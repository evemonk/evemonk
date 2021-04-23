# frozen_string_literal: true

require "spec_helper"

describe CharacterInvalidToken do
  specify { expect(subject).to be_a(RuntimeError) }
end
