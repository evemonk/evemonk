# frozen_string_literal: true

module Eve
  class Division < ApplicationRecord
    extend Mobility

    translates :name, :description_full, :leader_type_name

    has_many :agents
  end
end
