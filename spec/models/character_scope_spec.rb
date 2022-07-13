# frozen_string_literal: true

require "rails_helper"

describe CharacterScope do
  it { should be_an(ApplicationRecord) }

  it do
    expect(described_class::SCOPES).to eq(
      [
        "publicData",
        "esi-wallet.read_character_wallet.v1",
        "esi-characters.read_loyalty.v1",
        "esi-clones.read_implants.v1",
        "esi-clones.read_clones.v1",
        "esi-skills.read_skillqueue.v1",
        "esi-skills.read_skills.v1",
        "esi-assets.read_assets.v1",
        "esi-location.read_location.v1",
        "esi-location.read_online.v1",
        "esi-location.read_ship_type.v1",
        "esi-mail.read_mail.v1",
        "esi-characters.read_standings.v1",
        "esi-characters.read_blueprints.v1",
        "esi-killmails.read_killmails.v1",
        "esi-industry.read_character_jobs.v1",
        "esi-markets.read_character_orders.v1",
        "esi-corporations.read_corporation_membership.v1",
        "esi-calendar.read_calendar_events.v1"
      ]
    )
  end

  it { should belong_to(:character) }

  describe "#token_expired?" do
    context "when expired" do
      subject { build(:character_scope, token_expires_at: 1.hour.ago) }

      specify { expect(subject.token_expired?).to eq(true) }
    end

    context "when not expired" do
      subject { build(:character_scope, token_expires_at: 1.hour.from_now) }

      specify { expect(subject.token_expired?).to eq(false) }
    end
  end
end
