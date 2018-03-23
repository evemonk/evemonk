# frozen_string_literal: true

require 'rails_helper'

describe Character do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:user) }

  it { should belong_to(:race).class_name('Eve::Race').with_primary_key(:race_id) } # .optional(true) }

  it { should belong_to(:bloodline).class_name('Eve::Bloodline').with_primary_key(:bloodline_id) } # .optional(true) }

  it { should belong_to(:faction).class_name('Eve::Faction').with_primary_key(:faction_id) } # .optional(true) }

  it { should belong_to(:ancestry).class_name('Eve::Ancestry').with_primary_key(:ancestry_id) } # .optional(true) }

  it { should belong_to(:alliance).class_name('Eve::Alliance').with_primary_key(:alliance_id) } # .optional(true) }
end
