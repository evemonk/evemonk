# frozen_string_literal: true

module Eve
  class AllianceCorporationDecorator < ApplicationDecorator
    decorates_associations :alliance, :corporation
  end
end
