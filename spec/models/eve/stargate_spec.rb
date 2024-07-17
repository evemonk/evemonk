# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Stargate do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("stargate_id") }

  it { expect(described_class.table_name).to eq("eve_stargates") }

  it { is_expected.to belong_to(:system).optional }

  it { is_expected.to belong_to(:destination_stargate).class_name("Eve::Stargate").optional }

  it { is_expected.to belong_to(:destination_system).class_name("Eve::System").optional }

  it { is_expected.to belong_to(:type).optional }

  it { is_expected.to have_one(:position).dependent(:destroy) }
end
