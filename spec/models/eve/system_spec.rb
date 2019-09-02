# frozen_string_literal: true

require "rails_helper"

describe Eve::System do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class.table_name).to eq("eve_systems") }

  it { should have_many(:stargates).with_primary_key(:system_id) }
end
