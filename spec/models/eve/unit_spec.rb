# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Unit do
  it { is_expected.to be_an(ApplicationRecord) }

  it { is_expected.to have_many(:dogma_attributes) }
end
