# frozen_string_literal: true

class SignInService
  include ActiveModel::Model

  attr_accessor :email, :password, :remember_me, :controller

  validates :email, presence: true

  validates :password, presence: true

  delegate :login, to: :controller

  # validates :remember_me, inclusion: { in: ["0", "1"] }

  def save
    return false unless valid?

    # TODO: add remember_me e.g. controller.login(email, password, remember_me == 1)
    login(email, password)
  end
end
