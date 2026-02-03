# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::DeletedCharacter, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }
end
