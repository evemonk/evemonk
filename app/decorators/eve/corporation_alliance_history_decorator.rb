# frozen_string_literal: true

module Eve
  class CorporationAllianceHistoryDecorator < ApplicationDecorator
    decorates_associations :corporation, :alliance
  end
end
