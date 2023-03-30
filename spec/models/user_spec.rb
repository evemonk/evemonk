# frozen_string_literal: true

require "rails_helper"

describe User do
  it { should be_an(ApplicationRecord) }

  it_behaves_like "two_factor_authenticatable"

  it_behaves_like "two_factor_backupable"

  it {
    expect(described_class.devise_modules).to eq([:two_factor_authenticatable,
      :two_factor_backupable,
      :rememberable,
      :recoverable,
      :registerable,
      :validatable,
      :confirmable,
      :trackable,
      :zxcvbnable])
  }

  it { should have_many(:characters).dependent(:destroy) }

  it {
    should define_enum_for(:locale).with_values(auto_detect: 0,
      english: 1,
      german: 2,
      french: 3,
      japanese: 4,
      russian: 5,
      korean: 7)
  }

  describe "#otp_qr_code" do
    subject { build(:user, email: "me@example.com") }

    let(:uri) { double }

    before do
      #
      # otp_provisioning_uri(label, issuer: issuer) # => uri
      #
      expect(subject).to receive(:otp_provisioning_uri).with(
        "EveMonk:me@example.com",
        issuer: "EveMonk"
      ).and_return(uri)
    end

    let(:qrcode) { double }

    before do
      #
      # RQRCode::QRCode.new(otp_provisioning_uri(label, issuer: issuer)) # => qrcode
      #
      expect(RQRCode::QRCode).to receive(:new).with(uri).and_return(qrcode)
    end

    before { expect(qrcode).to receive(:as_svg).with(module_size: 4) }

    specify { expect { subject.otp_qr_code }.not_to raise_error }
  end
end
