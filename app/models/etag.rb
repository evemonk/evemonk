# frozen_string_literal: true

class Etag < ApplicationRecord
  validates :url, presence: true

  validates :url, uniqueness: true

  validates :etag, presence: true
end
