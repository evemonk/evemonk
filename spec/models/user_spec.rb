# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it {
    expect(described_class.devise_modules).to eq([:database_authenticatable,
      :rememberable,
      :recoverable,
      :registerable,
      :validatable,
      :confirmable,
      :trackable,
      :zxcvbnable])
  }

  it { expect(subject).to have_many(:characters).dependent(:destroy) }

  describe "#email" do
    context "when email is valid" do
      subject { build(:user, email: "me@example.com") }

      before { subject.valid? }

      it { expect(subject.errors[:email]).to eq([]) }
    end

    context "when email is valid with label" do
      subject { build(:user, email: "me+label@example.com") }

      before { subject.valid? }

      it { expect(subject.errors[:email]).to eq([]) }
    end

    context "when email is not valid" do
      subject { build(:user, email: "m..e@example.com") }

      before { subject.valid? }

      it { expect(subject.errors[:email]).to include("Invalid Email Address") }
    end
  end

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
