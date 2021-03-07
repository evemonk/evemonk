# frozen_string_literal: true

module Eve
  class EtagRecord < ApplicationRecord
    self.table_name = "eve_etags"

    # validates :url, presence: true
    #
    # validates :url, uniqueness: true
    #
    # validates :etag, presence: true
  end
end
