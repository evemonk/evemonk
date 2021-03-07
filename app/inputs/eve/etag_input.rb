# frozen_string_literal: true

module Eve
  class EtagInput < Upgrow::Input
    attribute :url
    attribute :etag
    attribute :body

    validates :url, presence: true
    validates :etag, presence: true
    validates :body, presence: true
  end
end
