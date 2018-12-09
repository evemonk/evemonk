# frozen_string_literal: true

require 'rails_helper'

describe Eve::Alliance do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('eve_alliances') }

  it { should have_many(:characters).dependent(:destroy) }
end
