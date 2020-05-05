# frozen_string_literal: true

module LocationableDecorator
  include ActiveSupport::Concern

  def location_formatted
    case location
    when Eve::StationDecorator
      "#{location.name} (#{location.system.security_status})"
    end
  end
end
