# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :sessions, dependent: :destroy

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

  validates :password, length: {minimum: 8, maximum: 72}, on: :create

  validates :email_address, presence: true

  validates :email_address, uniqueness: true

  validates :email_address, format: {with: URI::MailTo::EMAIL_REGEXP}
end
