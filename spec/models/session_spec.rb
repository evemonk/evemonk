# frozen_string_literal: true

require 'rails_helper'

describe Session do
  it { should be_a(ApplicationRecord) }

  it { should define_enum_for(:device_type).with_values([:ios, :android]) }

  it { should belong_to(:user) }

  describe 'validate device_token presence' do
    context 'when device_type present' do
      subject { described_class.new(device_type: :ios) }

      xit { should validate_presence_of(:device_token) } # TODO: update shoulda-matchers and enable this spec
    end

    context 'when device_type not present' do
      subject { described_class.new(device_type: nil) }

      xit { should_not validate_presence_of(:device_token) } # TODO: update shoulda-matchers and enable this spec
    end
  end

  # it { should have_secure_token } # TODO: update shoulda-matchers and enable this spec
end
