# frozen_string_literal: true

class User < ApplicationRecord
  devise :two_factor_authenticatable, :two_factor_backupable
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :registerable, :recoverable,
    :rememberable, :validatable, :confirmable, :trackable, :zxcvbnable

  has_many :characters, dependent: :destroy

  validates_with EmailAddress::ActiveRecordValidator, field: :email

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
end
