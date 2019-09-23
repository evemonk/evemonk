# frozen_string_literal: true

class SignInService
  include ActiveModel::Model

  attr_accessor :email, :password, :remember_me, :controller

  validates :email, presence: true

  validates :password, presence: true

  def save
    return false if !valid?

    controller.login(email, password, remember_me = remember_me)
  end
end
