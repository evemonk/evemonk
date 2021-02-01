# frozen_string_literal: true

module Eve
  class AllianceDecorator < ApplicationDecorator
    decorates_associations :creator_corporation, :creator,
      :executor_corporation, :faction, :corporations, :characters,
      :corporation_alliance_histories

    def date_founded
      object.date_founded.iso8601
    end
  end
end
