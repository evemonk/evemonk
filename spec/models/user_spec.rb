# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to have_secure_password }

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

  it { expect(subject).to validate_length_of(:password).is_at_least(8).is_at_most(72).on(:create) }

  it { expect(subject).to validate_presence_of(:email_address) }

  describe "email_address is expected to be unique" do
    let!(:user) { create(:user, email_address: "me@example.com") }

    subject { build(:user, email_address: "me@example.com", password: "password") }

    it { expect(subject).to validate_uniqueness_of(:email_address).ignoring_case_sensitivity }
  end

  describe "email_address is expected to be in URI::MailTo::EMAIL_REGEXP format" do
    context "when email_address is valid" do
      subject { build(:user, email_address: "me@example.com") }

      it { expect(subject.valid?).to eq(true) }
    end

    context "when email_address is not valid" do
      subject { build(:user, email_address: "me") }

      it { expect(subject.valid?).to eq(false) }
    end
  end
end
