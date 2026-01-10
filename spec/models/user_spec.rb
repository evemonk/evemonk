# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { should have_secure_password }

  it "is expected to normalizes email_address" do
    expect(described_class.new(email_address: " DOWNCASED@EXAMPLE.COM ").email_address)
      .to eq("downcased@example.com")
  end

  it { expect(subject).to have_many(:sessions).dependent(:destroy) }

  it { expect(subject).to have_many(:characters).dependent(:destroy) }

  it {
    expect(subject).to define_enum_for(:locale).with_values(
      auto_detect: 0,
      english: 1,
      german: 2,
      french: 3,
      japanese: 4,
      korean: 7
    )
  }
end
