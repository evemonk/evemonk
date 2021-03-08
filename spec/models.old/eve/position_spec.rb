# frozen_string_literal: true

require "rails_helper"

describe Eve::Position do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:positionable) }
end
