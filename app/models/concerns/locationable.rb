# frozen_string_literal: true

module Locationable
  include ActiveSupport::Concern

  # https://github.com/esi/esi-docs/blob/master/docs/asset_location_id.md
  def location
    return @location if @location

    case location_id
    when 60_000_000..64_000_000
      @location = Eve::Station.find_by(id: location_id)
    end
  end

  def location_formatted
    case location
    when Eve::Station
      "#{location.name} (#{location.system.rounded_security_status})"
    end
  end
end
