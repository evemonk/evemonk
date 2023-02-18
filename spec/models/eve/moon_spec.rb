# frozen_string_literal: true

require "rails_helper"

describe Eve::Moon do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { should belong_to(:system).optional(true) }

  it { should belong_to(:planet).optional(true) }

  it { should have_one(:position).dependent(:destroy) }
end
