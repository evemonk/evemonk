# frozen_string_literal: true

class User < ApplicationRecord
  devise :two_factor_authenticatable,
         otp_secret_encryption_key: ENV["OTP_SECRET_ENCRYPTION_KEY"]

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :registerable, :recoverable,
    :rememberable, :validatable, :confirmable, :trackable

  # TODO: drop oauth kind and then drop kind from users
  enum kind: [:normal, :oauth]

  has_many :sessions, dependent: :destroy

  has_many :characters, dependent: :destroy
end
