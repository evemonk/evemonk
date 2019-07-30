# frozen_string_literal: true

require "rails_helper"

describe Eve::Ancestry do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_ancestries") }

  it { should belong_to(:bloodline).with_primary_key(:bloodline_id).optional }
end
