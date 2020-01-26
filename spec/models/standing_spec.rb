# frozen_string_literal: true

require "rails_helper"

describe Standing do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { should belong_to(:character) }
end
