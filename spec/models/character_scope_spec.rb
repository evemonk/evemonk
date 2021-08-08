# frozen_string_literal: true

require "rails_helper"

describe CharacterScope do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:character) }
end
