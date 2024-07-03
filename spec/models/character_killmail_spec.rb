# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterKillmail do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:character) }
end
