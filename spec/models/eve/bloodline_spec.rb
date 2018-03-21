# frozen_string_literal: true

require 'rails_helper'

module Eve
  describe Bloodline do
    it { should be_a(ApplicationRecord) }

    it { expect(described_class.table_name).to eq('eve_bloodlines') }

    it { should validate_presence_of(:bloodline_id) }

    it { should validate_numericality_of(:bloodline_id).only_integer.is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:description) }

    it { should validate_presence_of(:race_id) }

    it { should validate_numericality_of(:race_id).only_integer.is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:ship_type_id) }

    it { should validate_numericality_of(:ship_type_id).only_integer.is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:corporation_id) }

    it { should validate_numericality_of(:corporation_id).only_integer.is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:perception) }

    it { should validate_numericality_of(:perception).only_integer.is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:willpower) }

    it { should validate_numericality_of(:willpower).only_integer.is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:charisma) }

    it { should validate_numericality_of(:charisma).only_integer.is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:memory) }

    it { should validate_numericality_of(:memory).only_integer.is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:intelligence) }

    it { should validate_numericality_of(:intelligence).only_integer.is_greater_than_or_equal_to(0) }
  end
end
