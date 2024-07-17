# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::War do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_wars") }
end
