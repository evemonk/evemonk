require 'rails_helper'

describe Session do
  it { should be_a(ApplicationRecord) }

  it { should define_enum_for(:device).with([:ios, :android]) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:user) }

  describe 'validate device_token presence' do
    context 'device present' do
      subject { stub_model Session, device: :ios }

      it { should validate_presence_of(:device_token) }
    end

    context 'device not present' do
      subject { stub_model Session }

      it { should_not validate_presence_of(:device_token) }
    end
  end

  pending { should have_secure_token }
end
