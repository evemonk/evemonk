# frozen_string_literal: true

require 'rails_helper'

describe Etag do
  it { should be_an(ApplicationRecord) }

  xit { should validate_presence_of(:url) }

  xit { should validate_presence_of(:etag) }
end
