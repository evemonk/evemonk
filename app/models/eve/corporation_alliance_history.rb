# frozen_string_literal: true

module Eve
  class CorporationAllianceHistory < ApplicationRecord
    belongs_to :corporation, optional: true

    belongs_to :alliance, optional: true
  end
end
