# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :validatable, :confirmable, :trackable, :zxcvbnable

  has_many :characters, dependent: :destroy

  enum locale: {auto_detect: 0,
                english: 1,
                german: 2,
                french: 3,
                japanese: 4,
                russian: 5,
                # chinese: 6,
                korean: 7}
end
