# frozen_string_literal: true

require "rails_helper"

describe EvemonkSchema do
  it { expect(described_class.default_max_page_size).to eq(50) }
end
