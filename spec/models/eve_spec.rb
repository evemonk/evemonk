# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve, type: :model do
  specify { expect(described_class.table_name_prefix).to eq("eve_") }
end
