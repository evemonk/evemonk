# frozen_string_literal: true

require 'rails_helper'

module Eve
  describe Faction do
    it { should be_a(ApplicationRecord) }

    it { expect(described_class.table_name).to eq('eve_factions') }
  end
end
