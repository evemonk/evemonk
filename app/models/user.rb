# frozen_string_literal: true

class User < ApplicationRecord
  devise :two_factor_authenticatable

  devise :two_factor_backupable,
    otp_backup_code_length: 10,
    otp_number_of_backup_codes: 16

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :registerable, :recoverable,
    :rememberable, :validatable, :confirmable, :trackable, :zxcvbnable

  has_many :characters, dependent: :destroy

  enum locale: {
    auto_detect: 0,
    english: 1,
    german: 2,
    french: 3,
    japanese: 4,
    russian: 5,
    # chinese: 6,
    korean: 7
  }

  def otp_qr_code
    issuer = "EveMonk"
    label = "#{issuer}:#{email}"
    qrcode = RQRCode::QRCode.new(otp_provisioning_uri(label, issuer: issuer))
    qrcode.as_svg(module_size: 4)
  end
end
