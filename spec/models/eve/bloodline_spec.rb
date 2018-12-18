# frozen_string_literal: true

require 'rails_helper'

describe Eve::Bloodline do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('eve_bloodlines') }
end
