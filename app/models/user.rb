# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :validatable, :confirmable, :trackable

  # TODO: drop oauth kind and then drop kind from users
  enum kind: [:normal, :oauth]

  has_many :sessions, dependent: :destroy

  has_many :characters, dependent: :destroy
end
