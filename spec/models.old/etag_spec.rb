# frozen_string_literal: true

require "rails_helper"

describe Etag do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:character) }

  it { should validate_presence_of(:url) }

  it { should validate_presence_of(:etag) }
end
