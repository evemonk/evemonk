# frozen_string_literal: true

class SignInForm
  include ActiveModel::Model

  attr_accessor :email, :password, :remember_me, :controller

  validates :email, presence: true

  validates :password, presence: true

  validates :remember_me, inclusion: {in: ["0", "1"]}

  delegate :login, to: :controller

  def save
    return false unless valid?

    login(email, password, remember_me == "1")
  end
end
