# frozen_string_literal: true

require 'rails_helper'

module Eve
  describe Position do
    it { should be_a(ApplicationRecord) }

    it { expect(described_class.table_name).to eq('inv_positions') }

    it { should validate_presence_of(:item_id) }

    it { should validate_presence_of(:x) }

    it { should validate_presence_of(:y) }

    it { should validate_presence_of(:z) }

    it { should validate_numericality_of(:item_id).only_integer.is_greater_than_or_equal_to(0) }
  end
end
