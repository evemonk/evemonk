# frozen_string_literal: true

module Eve
  class NpcCorporationDivision < ApplicationRecord
    extend Mobility

    translates :name, :description_full, :leader_type_name
  end
end
