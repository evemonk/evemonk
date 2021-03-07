# frozen_string_literal: true

module Eve
  class EtagRecord < ApplicationRecord
    self.table_name = "eve_etags"
  end
end
