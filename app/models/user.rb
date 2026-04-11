# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :validatable, :confirmable, :trackable, :omniauthable,
    :zxcvbnable, omniauth_providers: [:eve_online_sso]

  has_many :characters, dependent: :destroy

  enum :locale, {
    auto_detect: 0,
    english: 1,
    german: 2,
    french: 3,
    japanese: 4,
    # russian: 5,
    # chinese: 6,
    korean: 7
  }

  class << self
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.guest = true
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = "#{auth.uid}@evemonk.com"
        user.password = Devise.friendly_token[0, 20]
        user.skip_confirmation!
      end
    end
  end
end
