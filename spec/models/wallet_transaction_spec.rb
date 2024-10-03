# frozen_string_literal: true

require "rails_helper"

RSpec.describe WalletTransaction do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to be_a(Locationable) }

  it { expect(subject).to belong_to(:character) }

  it { expect(subject).to belong_to(:type).class_name("Eve::Type").optional }

  it { expect(subject).to belong_to(:wallet_journal).with_primary_key("wallet_journal_id").with_foreign_key("journal_ref_id").optional }

  it { expect(subject).to belong_to(:client).class_name("Eve::Character").with_primary_key("character_id").with_foreign_key("client_id").optional }
end
