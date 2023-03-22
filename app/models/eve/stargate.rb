# frozen_string_literal: true

module Eve
  class Stargate < ApplicationRecord
    self.primary_key = "stargate_id"

    belongs_to :system, optional: true

    belongs_to :destination_stargate, class_name: "Eve::Stargate", optional: true

    belongs_to :destination_system, class_name: "Eve::System", optional: true

    # has_one :stargate_destination, primary_key: :stargate_id, foreign_key: :from_stargate_id, dependent: :destroy

    belongs_to :type, optional: true

    has_one :position, as: :positionable, dependent: :destroy
  end
end
