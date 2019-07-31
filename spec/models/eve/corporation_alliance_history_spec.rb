# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationAllianceHistory do
  it { should belong_to(:corporation).with_primary_key(:corporation_id) }

  it { should belong_to(:alliance).with_primary_key(:alliance_id).optional }
end
