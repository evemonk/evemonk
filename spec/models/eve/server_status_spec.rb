# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::ServerStatus do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_server_statuses") }
end
