# frozen_string_literal: true

class SignUpForm
  include ActiveModel::Model

  attr_accessor :email, :password, :password_confirmation, :remember_me, :controller

  validates :email, presence: true

  validates :password, presence: true

  validates :password_confirmation, presence: true

  validates :password, confirmation: true

  validates :remember_me, inclusion: {in: ["0", "1"]}

  delegate :login, to: :controller

  def save
    return false unless valid?

    create_user!

    login(email, password, remember_me == "1")

    true
  rescue ActiveRecord::RecordNotUnique
    errors.add(:email, I18n.t("errors.messages.taken"))

    false
  end

  private

  def create_user!
    User.create!(email: email, password: password)
  end
end
