# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it {
    expect(described_class.devise_modules).to eq([:database_authenticatable,
      :rememberable,
      :omniauthable,
      :recoverable,
      :registerable,
      :validatable,
      :confirmable,
      :trackable,
      :zxcvbnable])
  }

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

  describe ".from_omniauth" do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: "eve_online_sso",
        uid: "1337512245"
      )
    end

    it "is expected to create user with provider and uid" do
      expect { described_class.from_omniauth(auth) }.to change(described_class, :count).by(1)

      user = described_class.last

      expect(user.provider).to eq("eve_online_sso")

      expect(user.uid).to eq("1337512245")

      expect(user.email).to eq("1337512245@evemonk.com")
    end
  end
end
