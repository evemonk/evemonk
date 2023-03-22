# frozen_string_literal: true

require "rails_helper"

describe Eve::Stargate do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("stargate_id") }

  it { expect(described_class.table_name).to eq("eve_stargates") }

  it { should belong_to(:system).optional(true) }

  it { should belong_to(:destination_stargate).class_name("Eve::Stargate").optional(true) }

  it { should belong_to(:destination_system).class_name("Eve::System").optional(true) }

  it { should belong_to(:type).optional(true) }

  it { should have_one(:position).dependent(:destroy) }
end
