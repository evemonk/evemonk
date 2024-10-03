# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Unit do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to have_many(:dogma_attributes) }
end
