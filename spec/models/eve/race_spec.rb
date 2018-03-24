# frozen_string_literal: true

require 'rails_helper'

module Eve
  describe Race do
    it { should be_a(ApplicationRecord) }

    it { expect(described_class.table_name).to eq('eve_races') }

    it { should have_many(:characters) }

    it { should validate_presence_of(:race_id) }

    it { should validate_numericality_of(:race_id).only_integer.is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:description) }

    it { should validate_presence_of(:alliance_id) }

    it { should validate_numericality_of(:alliance_id).only_integer.is_greater_than_or_equal_to(0) }
  end
end
