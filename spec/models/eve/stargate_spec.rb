# frozen_string_literal: true

require "rails_helper"

describe Eve::Stargate do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class.table_name).to eq("eve_stargates") }

  it { should belong_to(:system).with_primary_key("system_id").optional(true) }

  it { should have_one(:position).dependent(:destroy) }
end
