# frozen_string_literal: true

class SignInService
  include ActiveModel::Model

  attr_accessor :email, :password, :remember_me, :controller

  validates :email, presence: true

  validates :password, presence: true

  validates :remember_me, inclusion: { in: ["0", "1"] }

  def save
    return false if !valid?

    controller.login(email, password, remember_me == 1)
  end
end
