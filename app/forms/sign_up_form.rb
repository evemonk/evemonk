# frozen_string_literal: true

class SignUpForm
  include ActiveModel::Model

  attr_accessor :email, :password, :password_confirmation, :controller

  validates :email, presence: true

  validates :password, presence: true

  validates :password_confirmation, presence: true

  validates :password, confirmation: true

  def save
    return false unless valid?
  end
end
