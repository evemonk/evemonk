# frozen_string_literal: true

module Eve
  class AllianceDecorator < Draper::Decorator
    delegate_all

    def as_json(*)
      {
        alliance_id: alliance_id,
        name: name,
        creator_id: creator_id,
        creator_corporation_id: creator_corporation_id,
        ticker: ticker,
        executor_corporation_id: executor_corporation_id,
        date_founded: date_founded,
        faction_id: faction_id,
        icon_small: icon_small,
        icon_medium: icon_medium
      }
    end
  end
end
