# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  # TODO: drop oauth kind and then drop kind from users
  enum kind: [:normal, :oauth]

  has_many :sessions, dependent: :destroy

  has_many :characters, dependent: :destroy
end
