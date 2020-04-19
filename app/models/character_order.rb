# frozen_string_literal: true

class CharacterOrder < ApplicationRecord
  has_paper_trail

  belongs_to :character

  belongs_to :type,
    class_name: "Eve::Type",
    primary_key: "type_id",
    foreign_key: "type_id",
    optional: true

  belongs_to :region,
    class_name: "Eve::Region",
    primary_key: "region_id",
    foreign_key: "region_id",
    optional: true

  def location
    return @location if @location

    case location_id
    when 60_000_000..64_000_000
      @location = Eve::Station.find_by(station_id: location_id)
    end
  end
end
