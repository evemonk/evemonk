# frozen_string_literal: true

module Eve
  class StargateDecorator < ApplicationDecorator
    decorates_associations :system, :destination_stargate,
      :destination_system, :type, :position
  end
end
