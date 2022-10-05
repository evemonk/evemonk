# frozen_string_literal: true

require "rails_helper"

describe Eve::Unit do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { should have_many(:dogma_attributes) }
end
