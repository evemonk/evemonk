# frozen_string_literal: true

require "rails_helper"

describe Eve::War do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_wars") }
end
