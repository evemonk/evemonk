# frozen_string_literal: true

require "rails_helper"

describe Eve::EtagRecord, type: :model do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_etags") }
end
