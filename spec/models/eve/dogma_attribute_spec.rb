# frozen_string_literal: true

require "rails_helper"

describe Eve::DogmaAttribute do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:unit).with_primary_key("unit_id").optional(true) }
end
