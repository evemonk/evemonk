# frozen_string_literal: true

require 'rails_helper'

describe Eve::DogmaAttribute do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('eve_dogma_attributes') }
end
