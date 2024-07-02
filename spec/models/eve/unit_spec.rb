# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Unit do
  it { should be_an(ApplicationRecord) }

  it { should have_many(:dogma_attributes) }
end
