# frozen_string_literal: true

require "rails_helper"

RSpec.describe WalletJournal do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:character) }
end
