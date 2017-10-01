require 'rails_helper'

describe User do
  it { should be_a(ApplicationRecord) }

  it { should define_enum_for(:kind).with([:normal, :oauth]) }

  it { should have_many(:sessions).dependent(:destroy) }

  it { should have_many(:characters).dependent(:destroy) }

  context 'normal user' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }

    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  context 'oauth user' do
    subject { build(:user, :oauth) }

    it { should_not validate_presence_of(:email) }

    it { should_not validate_uniqueness_of(:email).case_insensitive }
  end

  it { should have_secure_password }
end
