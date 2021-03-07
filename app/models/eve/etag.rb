# frozen_string_literal: true

module Eve
  class Etag < Upgrow::Model
    attribute :url
    attribute :etag
    attribute :body
  end
end
