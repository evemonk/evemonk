# frozen_string_literal: true

require "rails_helper"

describe Eve::Agent do
  it { should be_an(ApplicationRecord) }

  it { should be_a(Locationable) }

  it { expect(described_class.table_name).to eq("eve_agents") }

  it { should respond_to(:versions) }

  it { should belong_to(:corporation).with_primary_key("corporation_id").optional(true) }

  it { should have_many(:standings) }
end
