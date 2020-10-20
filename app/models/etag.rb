# frozen_string_literal: true

class Etag < ApplicationRecord
  belongs_to :character

  validates :url, presence: true

  validates :etag, presence: true
end
