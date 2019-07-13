# frozen_string_literal: true

require 'rails_helper'

describe Character do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:user) }

  it { should belong_to(:race).class_name('Eve::Race').with_primary_key(:race_id).optional }

  it { should belong_to(:bloodline).class_name('Eve::Bloodline').with_primary_key(:bloodline_id).optional }

  it { should belong_to(:faction).class_name('Eve::Faction').with_primary_key(:faction_id).optional }

  it { should belong_to(:ancestry).class_name('Eve::Ancestry').with_primary_key(:ancestry_id).optional }

  it { should belong_to(:alliance).class_name('Eve::Alliance').with_primary_key(:alliance_id).optional }

  it { should belong_to(:corporation).class_name('Eve::Corporation').with_primary_key(:corporation_id).optional }

  it { should have_many(:loyalty_points).dependent(:destroy) }

  it { should have_many(:character_assets).dependent(:destroy) }

  describe '#token_expired?' do
    context 'when expired' do
      subject { create(:character, token_expires_at: Time.zone.now - 1.hour) }

      specify { expect(subject.token_expired?).to eq(true) }
    end

    context 'when not expired' do
      subject { create(:character, token_expires_at: Time.zone.now + 1.hour) }

      specify { expect(subject.token_expired?).to eq(false) }
    end
  end
end
