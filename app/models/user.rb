# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  enum kind: [:normal, :oauth]

  has_many :sessions, dependent: :destroy

  has_many :characters, dependent: :destroy

  # has_secure_password validations: false

  has_secure_token :reset_password_token
end
