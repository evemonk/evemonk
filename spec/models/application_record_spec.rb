require 'rails_helper'

describe ApplicationRecord do
  it { expect(described_class.abstract_class).to eq(true) }
end
