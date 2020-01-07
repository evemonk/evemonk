# frozen_string_literal: true

module Eve
  class Station < ApplicationRecord
    has_paper_trail

    # t.bigint :owner
    # t.bigint :race_id
    # t.bigint :station_id
    # t.bigint :system_id
    # t.bigint :type_id
  end
end
