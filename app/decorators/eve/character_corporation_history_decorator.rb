# frozen_string_literal: true

module Eve
  class CharacterCorporationHistoryDecorator < ApplicationDecorator
    decorates_associations :character, :corporation
  end
end
