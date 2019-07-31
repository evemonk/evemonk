# frozen_string_literal: true

require "rails_helper"

describe Eve::Stargate do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_stargates") }

  it { should belong_to(:system).with_primary_key(:system_id).optional }
end
