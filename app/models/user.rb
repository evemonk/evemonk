# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :authy_authenticatable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable, :trackable
  # :rememberable, :validatable, :confirmable, :trackable, :zxcvbnable

  has_many :sessions, dependent: :destroy

  has_many :characters, dependent: :destroy
end
