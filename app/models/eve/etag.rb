# frozen_string_literal: true

module Eve
  class Etag < ApplicationRecord
    validates :url, presence: true

    validates :url, uniqueness: true

    validates :etag, presence: true
  end
end
