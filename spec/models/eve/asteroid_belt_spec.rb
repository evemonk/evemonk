# frozen_string_literal: true

require "rails_helper"

describe Eve::AsteroidBelt do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { should belong_to(:system).with_primary_key("system_id").optional(true) }

  it { should belong_to(:planet).with_primary_key("planet_id").optional(true) }

  it { should have_one(:position).dependent(:destroy) }
end
