# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve do
  specify { expect(described_class.table_name_prefix).to eq("eve_") }
end
